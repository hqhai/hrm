import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionApproveBloc extends Bloc<RequisitionApproveEvent, RequisitionApproveState> {
  final RequisitionUseCase requisitionUseCase;

  RequisitionApproveBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const RequisitionApproveState()) {
    on<RequisitionApproveEvent>((event, emit) {});
    on<GetRequisitionsApproveByFilterEvent>(_getRequisitionsApproveByFilterEvent);
    on<GetRequisitionApproveByIdEvent>(_getRequisitionApproveByIdEvent);
    on<ApproveRequestEvent>(_approveRequestEvent);
  }

  List<Request> requisitions = [];

  FutureOr<void> _getRequisitionsApproveByFilterEvent(
      GetRequisitionsApproveByFilterEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(statusGet: RequisitionEnum.init));
    try {
      List<Request> requests = [];
      final RequestsResponse requestsResponse =
          await requisitionUseCase.getRequisitionsApproveByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime,
        startDate: event.startTime,
        type: event.requisitionTypeEnum?.name,
        status: event.status,
      );
      List<Request> newStationery = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      if (event.page != 1) {
        requests.addAll(state.requisitions);
        requests.addAll(newStationery);
        emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          statusGet: RequisitionEnum.success,
        ));

      } else {
        requests.addAll(newStationery);
        emit(state.copyWith(
            requisitions: requests, countItem: totalItems, statusGet: RequisitionEnum.success));
      }
    } catch (e) {
      emit(state.copyWith(statusGet: RequisitionEnum.fail));
    }
  }

  FutureOr<void> _getRequisitionApproveByIdEvent(
      GetRequisitionApproveByIdEvent event, Emitter<RequisitionApproveState> emit) {
    emit(state.copyWith(statusGetById: RequisitionEnum.init));
    try {
      emit(state.copyWith(requisition: event.requisition, statusGetById: RequisitionEnum.success));
    } catch (e) {
      emit(state.copyWith(statusGetById: RequisitionEnum.fail));
    }
  }

  FutureOr<void> _approveRequestEvent(
      ApproveRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(statusApprove: RequisitionEnum.init));
    try {
      final bool check = await requisitionUseCase.approveRequest(
          id: event.id, status: event.status?.name ?? "", note: event.note ?? "");
      if (check) {
        final requests = [...state.requisitions];
        int requestIndex = requests.indexWhere((element) => element.id == event.requestId);
        requests.removeAt(requestIndex);
        emit(state.copyWith(requisitions: requests, statusApprove: RequisitionEnum.success));
        event.completer.complete();
      } else {
        emit(state.copyWith(statusApprove: RequisitionEnum.fail));
        event.completer.complete();
      }
    } catch (e) {
      emit(state.copyWith(statusApprove: RequisitionEnum.fail));
      event.completer.complete();
    }
  }
}
