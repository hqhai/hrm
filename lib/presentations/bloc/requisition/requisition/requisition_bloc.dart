import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionBloc extends Bloc<RequisitionEvent, RequisitionState> {
  RequisitionBloc() : super(const RequisitionState()) {
    on<RequisitionEvent>((event, emit) {});
    on<GetRequisitionsEvent>(_getRequisitionsEvent);
    on<GetRequisitionsByFilterEvent>(_getRequisitionsByFilterEvent);
    on<GetRequisitionByIdEvent>(_getRequisitionByIdEvent);
  }

  List<Request> requisitions = [];

  FutureOr<void> _getRequisitionsEvent(GetRequisitionsEvent event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      emit(state.copyWith(
          requisitions: requisitions, status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionsByFilterEvent(
      GetRequisitionsByFilterEvent event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsInit));
    try {
      List<Request> requisitionsByFilter = state.requisitions;

      emit(state.copyWith(
          requisitions: requisitionsByFilter, status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionInit));
    try {
      emit(state.copyWith(
          requisition: event.requisition, status: RequisitionEnum.getRequisitionSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionError));
    }
  }
}
