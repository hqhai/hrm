import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
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
  }

  List<Requisition> requisitions = [
    Requisition(
      id: '66771508',
      type: RequisitionTypeEnum.explanation,
      status: StatusRequisitionEnum.pending.nameEn,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    Requisition(
      id: '415342574',
      type: RequisitionTypeEnum.leave,
      status: StatusRequisitionEnum.modification.nameEn,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
    ),
    Requisition(
      id: '75678768',
      type: RequisitionTypeEnum.postalDelivery,
      status: StatusRequisitionEnum.expiredEdit.nameEn,
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
}
