import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition.dart';
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
  }

  List<Requisition> requisitions = [
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.explanation,
      status: StatusRequisitionEnum.expiredEdit,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    const Requisition(
      id: '5673454',
      type: RequisitionTypeEnum.explanation,
      status: StatusRequisitionEnum.expired,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    const Requisition(
      id: '66771508',
      type: RequisitionTypeEnum.overtime,
      status: StatusRequisitionEnum.modification,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    const Requisition(
      id: '415342574',
      type: RequisitionTypeEnum.business,
      status: StatusRequisitionEnum.done,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    const Requisition(
      id: '75678768',
      type: RequisitionTypeEnum.postalDelivery,
      status: StatusRequisitionEnum.pending,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    )
  ];

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
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      List<Requisition> requisitionsByFilter = state.requisitions;

      emit(state.copyWith(
          requisitions: requisitionsByFilter, status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }
}
