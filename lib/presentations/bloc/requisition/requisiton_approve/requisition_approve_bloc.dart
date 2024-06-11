import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionApproveBloc extends Bloc<RequisitionApproveEvent, RequisitionApproveState> {
  RequisitionApproveBloc() : super(const RequisitionApproveState()) {
    on<RequisitionApproveEvent>((event, emit) {});
    on<GetRequisitionsApproveEvent>(_getRequisitionsApproveEvent);
    on<GetRequisitionsApproveByFilterEvent>(_getRequisitionsApproveByFilterEvent);
    on<GetRequisitionApproveByIdEvent>(_getRequisitionApproveByIdEvent);
  }

  List<Request> requisitions = [
  ];

  FutureOr<void> _getRequisitionsApproveEvent(
      GetRequisitionsApproveEvent event, Emitter<RequisitionApproveState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      emit(state.copyWith(
          requisitions: requisitions, status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionsApproveByFilterEvent(
      GetRequisitionsApproveByFilterEvent event, Emitter<RequisitionApproveState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsInit));
    try {
      List<Request> requisitionsByFilter = state.requisitions;

      emit(state.copyWith(
          requisitions: requisitionsByFilter, status: RequisitionEnum.getRequisitionsSuccess));
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
      emit(state.copyWith(status: RequisitionEnum.getRequisitionError));
    }
  }
}
