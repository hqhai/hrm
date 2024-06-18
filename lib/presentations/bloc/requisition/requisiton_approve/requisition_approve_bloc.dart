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
    on<GetRequisitionsApproveEvent>(_getRequisitionsApproveEvent);
    on<GetRequisitionsApproveByFilterEvent>(_getRequisitionsApproveByFilterEvent);
    on<GetRequisitionApproveByIdEvent>(_getRequisitionApproveByIdEvent);
    on<ApproveRequestEvent>(_approveRequestEvent);
    on<RemoveFilterEvent>(_removeFilterEvent);
  }

  List<Request> requisitions = [];

  FutureOr<void> _getRequisitionsApproveEvent(
      GetRequisitionsApproveEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsApprove(
        page: event.page,
      );
      List<Request> newStationery = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      requests.addAll(state.requisitions);
      requests.addAll(newStationery);
      emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionsApproveByFilterEvent(
      GetRequisitionsApproveByFilterEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsInit));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsApproveByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime,
        startDate: event.startTime,
        type: event.requisitionTypeEnum?.name,
        status: event.status,
      );
      List<Request> newStationery = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      if ((state.statusRequest == event.status) &&
          (state.startTime == event.startTime || event.startTime == null) &&
          (state.endTime == event.endTime || event.endTime == null) &&
          (state.requisitionTypeEnum == event.requisitionTypeEnum?.name ||
              event.requisitionTypeEnum == null) &&
          event.page != 0 &&
          event.page != 1) {
        requests.addAll(state.requisitions);
        requests.addAll(newStationery);
        emit(state.copyWith(
          statusRequest: event.status,
          endTime: event.endTime,
          startTime: event.startTime,
          requisitionTypeEnum: event.requisitionTypeEnum?.name,
          departmentId: event.departmentId,
          page: event.page,
          requisitions: requests,
          countItem: totalItems,
          status: RequisitionEnum.getRequisitionsSuccess,
        ));
      } else {
        requests.addAll(newStationery);
        emit(state.copyWith(
            endTime: event.endTime,
            startTime: event.startTime,
            requisitionTypeEnum: event.requisitionTypeEnum?.name,
            departmentId: event.departmentId,
            page: event.page,
            requisitions: requests,
            countItem: totalItems,
            status: RequisitionEnum.getRequisitionsSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionApproveByIdEvent(
      GetRequisitionApproveByIdEvent event, Emitter<RequisitionApproveState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionInit));
    try {
      emit(state.copyWith(
          requisition: event.requisition, status: RequisitionEnum.getRequisitionSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _approveRequestEvent(
      ApproveRequestEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.approveRequisitionInit));
    try {
      await requisitionUseCase.approveRequest(
          id: event.id, status: event.status?.name ?? "", note: event.note ?? "");
      emit(state.copyWith(status: RequisitionEnum.approveRequisitionSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.approveRequisitionError));
    }
  }

  FutureOr<void> _removeFilterEvent(
      RemoveFilterEvent event, Emitter<RequisitionApproveState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsApproveByFilter(
        page: 1,
        status: event.status,
      );
      List<Request> newStationery = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      requests.addAll(newStationery);
      emit(state.copyWith(
        requisitionTypeEnum: null,
          startTime: null,
          endTime: null,
          departmentId: null,
          statusRequest: event.status,
          requisitions: requests,
          countItem: totalItems,
          status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }
}
