import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:themes/themes.dart';

@lazySingleton
class RequisitionBloc extends HydratedBloc<RequisitionEvent, RequisitionState> {
  final RequisitionUseCase requisitionUseCase;
  final RequestUseCase _requestUseCase;
  final RequisitionService _requestService;

  RequisitionBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        _requestUseCase = dI<RequestUseCase>(),
        _requestService = dI<RequisitionService>(),
        super(const RequisitionState()) {
    on<RequisitionEvent>((event, emit) {});
    on<GetRequisitionsByFilterEvent>(_getRequisitionsByFilterEvent);
    on<GetRequisitionByIdEvent>(_getRequisitionByIdEvent);
    on<PostRequestEvent>(_postRequestEvent);
    on<UserRejectRequestEvent>(_userRejectRequestEvent);
    on<EditRequestEvent>(_editRequestEvent);
    on<ResetRequisitionEvent>(_resetRequisitionEvent);
    on<GetRequisitionUserCountEvent>(_getRequisitionUserCountEvent);
  }

  ///Reject request      ***********************************************
  FutureOr<void> _userRejectRequestEvent(
      UserRejectRequestEvent event, Emitter<RequisitionState> emit) async {
    try {
      final bool check = await requisitionUseCase.userRejectRequisitionById(id: event.id ?? "");
      if (check) {
        final requestIds = state.requisitionIds.where((element) => element != event.id).toList();
        final countRequest = state.statusCount;
        countRequest[StatusRequestEnum.approve] =
            (countRequest[StatusRequestEnum.approve] ?? 0) - 1;
        countRequest[StatusRequestEnum.cancel] = (countRequest[StatusRequestEnum.cancel] ?? 0) + 1;
        emit(state.copyWith(
          requisitionIds: requestIds,
          errorCode: '',
          statusCount: countRequest,
        ));
        event.completer?.complete(true);
      } else {
        event.completer?.complete(false);
      }
    } catch (e) {
      if (e is ResponseBase) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
      }
    }
  }

  ///get by filter ***********************************************
  FutureOr<void> _getRequisitionsByFilterEvent(
      GetRequisitionsByFilterEvent event, Emitter<RequisitionState> emit) async {
    try {
      final RequestsResponse requestsResponse =
          await requisitionUseCase.getRequisitionsSelfByFilter(
        page: event.page,
        flowId: event.flowIds,
        status: event.status,
        startDate: event.startTime?.subtract(const Duration(hours: 7)),
        endDate: event.endTime?.subtract(const Duration(hours: 7)),
      );
      final List<Request> newRequest = requestsResponse.items;
      final int totalItems = requestsResponse.pagingInfo.totalItems;
      final Map<String, Request> mapRequests = Map.fromEntries(
        newRequest.map(
          (item) => MapEntry(
            item.id,
            item,
          ),
        ),
      );
      final List<String> requestsIds = newRequest.map((e) => e.id).toList();
      // load more *********************
      if (event.page != 1) {
        final Map<String, Request> requests = state.requisitions;
        requests.addAll(mapRequests);
        final oldRequestsIds = [...state.requisitionIds, ...requestsIds];
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: oldRequestsIds,
          requisitions: requests,
          countItem: totalItems,
        ));
        event.completer?.complete(true);
      }

      /// load more *********************
      else {
        dI<RequisitionBloc>().add(GetRequisitionUserCountEvent(
          startTime: event.startTime,
          endTime: event.endTime,
          flowIds: event.flowIds,
        ));
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: requestsIds,
          requisitions: mapRequests,
          countItem: totalItems,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      if (e is ResponseBase) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        event.completer?.complete(false);
      }
    }
  }

  ///get by id     ***********************************************
  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) async {
    try {
      final request = await requisitionUseCase.getRequisitionById(
        id: event.id ?? "",
      );

      dI<FlowBloc>().add(GetFlowEvent(id: request.flowId));
      dI<UserByIdBloc>().add(
        GetSubtitudePersonsByIdEvent(
          ids: request.config.subtitudePersons,
        ),
      );
      dI<UserByIdBloc>().add(
        GetUsersByIdEvent(ids: request.followerIds),
      );
      emit(state.copyWith(requisition: request, errorCode: ''));
      event.completer?.complete(true);
    } catch (e) {
      if (e is ResponseBase) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        event.completer?.complete(false);
      }
    }
  }

  ///Post Request     ***********************************************
  FutureOr<void> _postRequestEvent(PostRequestEvent event, Emitter<RequisitionState> emit) async {
    try {
      if (event.files.isNotEmpty) {
        final List<String> paths = [...await listPaths(event.files)];
        final ConfigModelRequest configRequestModel = event.postRequestRequest.config;
        final PostRequestRequest postRequestRequest = event.postRequestRequest
            .copyWith(config: configRequestModel.copyWith(attachments: paths));
        await requisitionUseCase.postRequest(postRequestRequest: postRequestRequest);
        emit(state.copyWith(
          errorCode: '',
        ));
        completerSuccess(requestId: '');
      } else {
        await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
        emit(state.copyWith(
          errorCode: '',
        ));
        completerSuccess(requestId: '');
      }
    } catch (e) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      if (e is ResponseBase) {
        final String errorCode = e.errorMessages.first.errorCode ?? '';
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        if (currentContext.mounted) {
          final colors = AppTheme.getColors(currentContext);
          dI<AppNavigation>().pop(currentContext);
          final errorDialog = ErrorUtils.getErrorMessage(errorCode, context: currentContext);
          Fluttertoast.showToast(
              msg: errorDialog,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: colors.error,
              textColor: colors.background,
              fontSize: SpacingUnit.x4);
        }
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        if (currentContext.mounted) {
          final colors = AppTheme.getColors(currentContext);
          dI<AppNavigation>().pop(currentContext);
          final errorDialog = ErrorUtils.getErrorMessage('error', context: currentContext);
          Fluttertoast.showToast(
              msg: errorDialog,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: colors.error,
              textColor: colors.background,
              fontSize: SpacingUnit.x4);
        }
      }
    }
  }

  ///Post files *******************************
  Future<List<String>> listPaths(List<File> files) async {
    List<Future<String>> futures = files.map((file) async {
      return await _requestUseCase.uploadFile(originFile: file);
    }).toList();
    List<String> paths = await Future.wait(futures);
    return paths;
  }

  ///Edit Request     ***********************************************
  FutureOr<void> _editRequestEvent(EditRequestEvent event, Emitter<RequisitionState> emit) async {
    try {
      if (event.files.isNotEmpty) {
        final List<String> paths = [...await listPaths(event.files)];
        final ConfigModelRequest configRequestModel = event.postRequestRequest.config;
        final PostRequestRequest postRequestRequest = event.postRequestRequest
            .copyWith(config: configRequestModel.copyWith(attachments: paths));
        final Request request =
            await requisitionUseCase.editRequestEdit(postRequestRequest: postRequestRequest);
        final requests = state.requisitions;
        requests[event.postRequestRequest.id ?? ""] = request;
        emit(state.copyWith(
          errorCode: '',
          requisition: request,
          requisitions: requests,
        ));
        completerSuccess(requestId: '');
      } else {
        final Request request =
            await requisitionUseCase.editRequestEdit(postRequestRequest: event.postRequestRequest);
        final requests = state.requisitions;
        requests[event.postRequestRequest.id ?? ""] = request;

        emit(state.copyWith(
          errorCode: '',
          requisition: request,
          requisitions: requests,
        ));

        final ids = state.requisitionIds
            .where((element) => element != event.postRequestRequest.id)
            .toList();
        completerSuccess(requestId: event.postRequestRequest.id ?? "");
        emit(state.copyWith(requisitionIds: ids));
      }
    } catch (e) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      if (e is ResponseBase) {
        final String errorCode = e.errorMessages.first.errorCode ?? '';
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        if (currentContext.mounted) {
          final colors = AppTheme.getColors(currentContext);
          dI<AppNavigation>().pop(currentContext);
          final errorDialog = ErrorUtils.getErrorMessage(errorCode, context: currentContext);
          Fluttertoast.showToast(
              msg: errorDialog,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: colors.error,
              textColor: colors.background,
              fontSize: SpacingUnit.x4);
        }
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        if (currentContext.mounted) {
          final colors = AppTheme.getColors(currentContext);
          dI<AppNavigation>().pop(currentContext);
          final errorDialog = ErrorUtils.getErrorMessage('error', context: currentContext);
          Fluttertoast.showToast(
              msg: errorDialog,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: colors.error,
              textColor: colors.background,
              fontSize: SpacingUnit.x4);
        }
      }
    }
  }

  /// Lay so luong request
  FutureOr<void> _getRequisitionUserCountEvent(
      GetRequisitionUserCountEvent event, Emitter<RequisitionState> emit) async {
    final requisitionCountStatus = await _requestService.userRequisitionCountStatus(
      getRequestFilterRequest: GetRequestFilterRequest(
        flowIds: event.flowIds,
        startDate: event.startTime?.subtract(const Duration(hours: 7)),
        endDate: event.endTime?.subtract(const Duration(hours: 7)),
      ),
    );
    final statusRequestCount = {
      StatusRequestEnum.process: requisitionCountStatus.newRequest,
      StatusRequestEnum.reject: requisitionCountStatus.reject,
      StatusRequestEnum.edit: requisitionCountStatus.edit,
      StatusRequestEnum.approve: requisitionCountStatus.approve,
      StatusRequestEnum.cancel: requisitionCountStatus.cancel,
      StatusRequestEnum.overdueApprove: requisitionCountStatus.overdueApprove,
      StatusRequestEnum.overdueEdit: requisitionCountStatus.overdueEdit,
    };
    emit(state.copyWith(statusCount: statusRequestCount));
  }

  @override
  RequisitionState? fromJson(Map<String, dynamic> json) {
    return RequisitionState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RequisitionState state) {
    return state.toJson();
  }

  FutureOr<void> _resetRequisitionEvent(
      ResetRequisitionEvent event, Emitter<RequisitionState> emit) {
    emit(const RequisitionState());
  }
}
