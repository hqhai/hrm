import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approves_step_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/cancel_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionApproveBloc
    extends HydratedBloc<RequisitionApproveEvent, RequisitionApproveState> {
  final RequisitionUseCase requisitionUseCase;
  final RequisitionService _requestService;

  RequisitionApproveBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        _requestService = dI<RequisitionService>(),
        super(const RequisitionApproveState()) {
    on<RequisitionApproveEvent>((event, emit) {});
    on<GetRequisitionsApproveByFilterEvent>(
        _getRequisitionsApproveByFilterEvent);
    on<ApproveRequestEvent>(_approveRequestEvent);
    on<GetRequisitionApproveCountEvent>(_getRequisitionApproveCountEvent);
    on<CancelRequestEvent>(_cancelRequestEvent);
    on<ResetRequisitionApproveEvent>(_resetRequisitionApproveEvent);
    on<AddIdRequisitionEvent>(_addIdRequisitionEvent);
    on<AddAllRequisitionEvent>(_addAllRequisitionEvent);
    on<ResetAllIdRequisitionApproveEvent>(_resetAllIdRequisitionApproveEvent);
  }

  ///get by filter ***********************************************

  FutureOr<void> _getRequisitionsApproveByFilterEvent(
      GetRequisitionsApproveByFilterEvent event,
      Emitter<RequisitionApproveState> emit) async {
    try {
      final RequestsResponse requestsResponse =
          await requisitionUseCase.getRequisitionsApproveByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime?.subtract(const Duration(hours: 7)),
        startDate: event.startTime?.subtract(const Duration(hours: 7)),
        type: event.type,
        userId: event.userIds,
        status: event.status,
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

      /// load more *********************
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
      } else {
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: requestsIds,
          requisitions: mapRequests,
          countItem: totalItems,
        ));
        dI<RequisitionApproveBloc>().add(GetRequisitionApproveCountEvent(
          departmentId: event.departmentId,
          endTime: event.endTime,
          startTime: event.startTime,
          type: event.type,
          userCode: event.userIds,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      if (e is ResponseBase) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(errorCode: errorCode));
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(errorCode: 'errorCode'));
        event.completer?.complete(false);
      }
    }
  }

  ///Approved request ****************************
  FutureOr<void> _approveRequestEvent(
      ApproveRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    try {
      final bool check = await requisitionUseCase.approveRequest(
        id: event.id,
        status: event.status.name,
        note: event.note ?? "",
      );
      if (check) {
        final requestIds = state.requisitionIds
            .where((element) => element != event.requestId)
            .toList();
        final statusRequestCount = state.statusRequestCount;
        statusRequestCount[EnumStepRequestStatusEnum.newStatus] =
            (statusRequestCount[EnumStepRequestStatusEnum.newStatus] ?? 0) - 1;
        statusRequestCount[event.status] =
            (statusRequestCount[event.status] ?? 0) + 1;
        emit(
          state.copyWith(
            requisitionIds: requestIds,
            statusRequestCount: statusRequestCount,
            errorCode: '',
          ),
        );

        dI<RequisitionApproveBloc>().add(
          GetRequisitionsApproveByFilterEvent(
            completer: event.completer,
            page: 1,
            departmentId: event.departmentId,
            startTime: event.startDate,
            endTime: event.endDate,
            type: event.type,
            status: event.statusCall,
            userIds: event.userId,
          ),
        );
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
        event.completer?.complete(false);
      }
    }
  }

  FutureOr<void> _getRequisitionApproveCountEvent(
      GetRequisitionApproveCountEvent event,
      Emitter<RequisitionApproveState> emit) async {
    final requisitionCountStatus =
        await _requestService.approveRequisitionCountStatus(
      getRequestApproveFilterRequest: GetRequestApproveFilterRequest(
          startDate: event.startTime?.subtract(const Duration(hours: 7)),
          endDate: event.endTime?.subtract(const Duration(hours: 7)),
          createdCode: event.userCode,
          types: event.type,
          createdDepartmentId: event.departmentId),
    );
    final statusRequestCount = {
      EnumStepRequestStatusEnum.newStatus: requisitionCountStatus.newRequest,
      EnumStepRequestStatusEnum.reject: requisitionCountStatus.reject,
      EnumStepRequestStatusEnum.edit: requisitionCountStatus.edit,
      EnumStepRequestStatusEnum.approve: requisitionCountStatus.approve,
      EnumStepRequestStatusEnum.cancel: requisitionCountStatus.cancel,
      EnumStepRequestStatusEnum.overdueApprove:
          requisitionCountStatus.overdueApprove,
    };
    emit(state.copyWith(statusRequestCount: statusRequestCount));
  }

  FutureOr<void> _cancelRequestEvent(
      CancelRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    try {
      await _requestService.cancelRequestsById(
          cancelRequest: CancelRequest(
        id: event.requestId,
        note: event.note,
      ));
      final requestIds = state.requisitionIds
          .where((element) => element != event.requestId)
          .toList();
      final statusRequestCount = state.statusRequestCount;
      statusRequestCount[EnumStepRequestStatusEnum.approve] =
          (statusRequestCount[EnumStepRequestStatusEnum.approve] ?? 0) - 1;
      statusRequestCount[EnumStepRequestStatusEnum.cancel] =
          (statusRequestCount[EnumStepRequestStatusEnum.cancel] ?? 0) + 1;
      emit(
        state.copyWith(
          statusRequestCount: statusRequestCount,
          requisitionIds: requestIds,
          errorCode: '',
        ),
      );
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

  void _addIdRequisitionEvent(
      AddIdRequisitionEvent event, Emitter<RequisitionApproveState> emit) {
    List<String> ids = [...state.ids];
    if (ids.contains(event.id)) {
      ids.remove(event.id);
    } else {
      ids = [...ids, event.id];
    }
    emit(state.copyWith(ids: ids));
  }

  @override
  RequisitionApproveState? fromJson(Map<String, dynamic> json) {
    return RequisitionApproveState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RequisitionApproveState state) {
    return state.toJson();
  }

  FutureOr<void> _resetRequisitionApproveEvent(
    ResetRequisitionApproveEvent event,
    Emitter<RequisitionApproveState> emit,
  ) {
    emit(const RequisitionApproveState());
  }

  void _resetAllIdRequisitionApproveEvent(
    ResetAllIdRequisitionApproveEvent event,
    Emitter<RequisitionApproveState> emit,
  ) {
    emit(state.copyWith(ids: []));
  }

  FutureOr<void> _addAllRequisitionEvent(
    AddAllRequisitionEvent event,
    Emitter<RequisitionApproveState> emit,
  ) async {
    try {
      final request = ApprovesStepRequest(
          stepRequestApproverId: event.stepRequestApproverId);
      final response = await requisitionUseCase.approveRequisitions(
          approvesStepRequest: request);
      if (response) {
        final Completer completer2 = Completer<bool>();
        dI<RequisitionApproveBloc>().add(GetRequisitionsApproveByFilterEvent(
          departmentId: event.departmentId,
          startTime: event.startTime,
          endTime: event.endTime,
          userIds: event.userIds,
          status: event.status,
          type: event.type,
          completer: completer2,
        ));
        await completer2.future;
        event.completer?.complete(true);
        emit(state.copyWith(ids: []));
      } else {
        event.completer?.complete(false);
      }
    } catch (e) {
      if (e is ResponseBase) {
        final error = e.errorMessages;
        if (error.isNotEmpty) {
          emit(state.copyWith(errorCode: error.first.errorCode));
        } else {
          emit(state.copyWith(errorCode: ''));
        }
      } else {
        emit(state.copyWith(errorCode: 'error'));
      }
      event.completer?.complete(false);
    }
  }
}
