import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/requisition.dart';
import 'package:base_app/domain/entities/reqisition/requisition_business_trip.dart';
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
      id: '123455',
      type: RequisitionTypeEnum.business,
      status: StatusRequisitionEnum.pending,
      title: "Hôm nay tôi nghỉ",
      content: RequisitionBusinessTrip(
        content: "Đi sài gòn thăm con méng",
        endTime: '2024-07-12 12:00:00',
        startTime: '2024-07-15 12:00:00',
        accompanyingPerson: 'DBT',
        destination: "Tp, Hồ Chí Minh",
        numberDays: 3,
        vehicle: 'Máy bay'
      ),
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van T',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.explanation,
      status: StatusRequisitionEnum.done,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.business,
      status: StatusRequisitionEnum.modification,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.vehicleDispatch,
      status: StatusRequisitionEnum.expired,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.overtime,
      status: StatusRequisitionEnum.expiredEdit,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
    const Requisition(
      id: '3544353',
      type: RequisitionTypeEnum.leave,
      status: StatusRequisitionEnum.reject,
      title: "Hôm nay tôi nghỉ",
      content: 'Không có content',
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: [],
    ),
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
