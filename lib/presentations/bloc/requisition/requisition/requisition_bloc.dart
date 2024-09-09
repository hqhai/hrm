import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionBloc extends Bloc<RequisitionEvent, RequisitionState> {
  final RequisitionUseCase requisitionUseCase;
  final RequestUseCase _requestUseCase;

  RequisitionBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        _requestUseCase = dI<RequestUseCase>(),
        super(const RequisitionState()) {
    on<RequisitionEvent>((event, emit) {});
    on<GetRequisitionsByFilterEvent>(_getRequisitionsByFilterEvent);
    on<GetRequisitionByIdEvent>(_getRequisitionByIdEvent);
    on<PostRequestEvent>(_postRequestEvent);
    on<UserRejectRequestEvent>(_userRejectRequestEvent);
    on<EditRequestEvent>(_editRequestEvent);
  }

  ///Reject request      ***********************************************
  FutureOr<void> _userRejectRequestEvent(
      UserRejectRequestEvent event, Emitter<RequisitionState> emit) async {
    try {
      final bool check = await requisitionUseCase.userRejectRequisitionById(id: event.id ?? "");
      if (check) {
        final requestIds = state.requisitionIds.where((element) => element != event.id).toList();
        emit(state.copyWith(
          requisitionIds: requestIds,
          errorCode: '',
        ));
        event.completer?.complete(true);
      } else {
        event.completer?.complete(false);
      }
    } catch (e) {
      event.completer?.complete(false);
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
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
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: requestsIds,
          requisitions: mapRequests,
          countItem: totalItems,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      event.completer?.complete(false);
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
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
      event.completer?.complete(false);
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(
        errorCode: errorCode,
      ));
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
        event.completer?.complete(true);
      } else {
        await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
        emit(state.copyWith(
          errorCode: '',
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
        event.completer?.complete(false);
        emit(state.copyWith(
          errorCode: 'error',
        ));
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
      final Request request =
          await requisitionUseCase.editRequestEdit(postRequestRequest: event.postRequestRequest);
      final requests = state.requisitions;
      requests[event.postRequestRequest.id ?? ""] = request;
      emit(state.copyWith(
        errorCode: '',
        requisition: request,
        requisitions: requests,
      ));
      event.completer?.complete(true);
    } catch (e) {
      if (e is ResponseBase) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(
          errorCode: errorCode,
        ));
        event.completer?.complete(false);
      } else {
        event.completer?.complete(false);
        emit(state.copyWith(
          errorCode: 'error',
        ));
      }
    }
  }
}
