import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionApproveBloc extends Bloc<RequisitionApproveEvent, RequisitionApproveState> {
  final RequisitionUseCase requisitionUseCase;
  final RequisitionService _requestService;

  RequisitionApproveBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        _requestService = dI<RequisitionService>(),
        super(const RequisitionApproveState()) {
    on<RequisitionApproveEvent>((event, emit) {});
    on<GetRequisitionsApproveByFilterEvent>(_getRequisitionsApproveByFilterEvent);
    on<ApproveRequestEvent>(_approveRequestEvent);
    on<GetRequisitionApproveCountEvent>(_getRequisitionApproveCountEvent);
    on<CancelRequestEvent>(_cancelRequestEvent);
  }

  ///get by filter ***********************************************

  FutureOr<void> _getRequisitionsApproveByFilterEvent(
      GetRequisitionsApproveByFilterEvent event, Emitter<RequisitionApproveState> emit) async {
    try {
      final RequestsResponse requestsResponse =
          await requisitionUseCase.getRequisitionsApproveByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime,
        startDate: event.startTime,
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
        event.completer?.complete(true);
      }
    } catch (e) {
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }

  ///Approved request ****************************
  FutureOr<void> _approveRequestEvent(
      ApproveRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    try {
      final bool check = await requisitionUseCase.approveRequest(
          id: event.id, status: event.status?.name ?? "", note: event.note ?? "");
      if (check) {
        final requestIds =
            state.requisitionIds.where((element) => element != event.requestId).toList();

        emit(
          state.copyWith(
            requisitionIds: requestIds,
            errorCode: '',
          ),
        );
        event.completer?.complete(true);
      } else {
        event.completer?.complete(false);
      }
    } catch (e) {
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getRequisitionApproveCountEvent(
      GetRequisitionApproveCountEvent event, Emitter<RequisitionApproveState> emit) async {
    final requisitionCountStatus = await _requestService.approveRequisitionCountStatus();
    final statusRequestCount = {
      EnumStepRequestStatusEnum.newStatus: requisitionCountStatus.newRequest,
      EnumStepRequestStatusEnum.reject: requisitionCountStatus.reject,
      EnumStepRequestStatusEnum.edit: requisitionCountStatus.edit,
      EnumStepRequestStatusEnum.approve: requisitionCountStatus.approve,
      EnumStepRequestStatusEnum.cancel: requisitionCountStatus.cancel,
      EnumStepRequestStatusEnum.overdueApprove: requisitionCountStatus.overdueApprove,
    };
    emit(state.copyWith(statusRequestCount: statusRequestCount));
  }

  FutureOr<void> _cancelRequestEvent(
      CancelRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    try {
      await _requestService.cancelRequestsById(id: event.requestId);
      final requestIds =
      state.requisitionIds.where((element) => element != event.requestId).toList();
      emit(
        state.copyWith(
          requisitionIds: requestIds,
          errorCode: '',
        ),
      );
      event.completer?.complete(true);
    } catch (e) {
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
      event.completer?.complete(false);
    }
  }
}
