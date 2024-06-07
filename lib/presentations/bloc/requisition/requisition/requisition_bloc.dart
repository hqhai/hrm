import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/requisition.dart';
import 'package:base_app/domain/entities/reqisition/requisition_business_trip.dart';
import 'package:base_app/domain/entities/reqisition/requisition_explanation.dart';
import 'package:base_app/domain/entities/reqisition/requisition_postal_delivery_service.dart';
import 'package:base_app/domain/entities/reqisition/requisition_vehicle_dispatch.dart';
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

  List<Requisition> requisitions = [
    const Requisition(
      id: '123451',
      type: RequisitionTypeEnum.business,
      status: StatusRequisitionEnum.pending,
      title: "Hôm nay tôi nghỉ",
      content: RequisitionBusinessTrip(
          content: "Đi sài gòn thăm con méng",
          endDate: '2024-07-12 12:00:00',
          startDate: '2024-07-15 12:00:00',
          substitutePersons: ['sdfhkfgfdsfsdfsdf', 'ádhgsajhdgjsad', 'saydgsaydgsdgggy'],
          totalTime: 3,
          vehicle: 'Máy bay'),
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van T',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: ['https://s3-sgn10.fptcloud.com/fsel/Files/alo_alo_123_1717752515.pdf'],
    ),
    const Requisition(
      id: '123452',
      type: RequisitionTypeEnum.vehicleDispatch,
      status: StatusRequisitionEnum.done,
      title: "Hôm nay tôi nghỉ",
      content: RequisitionVehicleDispatch(
          time: '2024-07-15 12:00:00',
          endTime: '2024-07-12 12:00:00',
          startTime: '2024-07-15 12:00:00',
          reasonForCallingACar:
              "VGMs, or Verified Gross Mass, refers to the regulation requiring shippers to verify the gross mass of packed containers before loading them onto ships. This regulation was introduced by the International Maritime Organization (IMO) as part of the Safety of Life at Sea (SOLAS) amendments, which came into effect on July 1, 2016.",
          schedule: "Đi chơi với méng ",
          carCaller: 'Nguyen Van A',
          drive: 'Nguyen Van D'),
      createTime: '2024-03-12 12:04:00',
      creator: 'Nguyen Van A',
      deadLine: '2024-07-12 12:04:00',
      department: "Fsel",
      creatorId: "0a94c6a8-4c9c-480e-9739-97f79e53dc45",
      follower: "Nguyen Van B",
      position: "Nhan vien",
      filePaths: ['https://s3-sgn10.fptcloud.com/fsel/Questions/alo_alo_123_1717471828.pdf'],
    ),
    const Requisition(
      id: '123453',
      type: RequisitionTypeEnum.postalDelivery,
      status: StatusRequisitionEnum.modification,
      title: "Hôm nay tôi nghỉ",
      content: RequisitionPostalDeliveryService(
        content: "Gửi mèo về quê",
        shippingPurpose: "Gửi mèo về quê cho mẹ chăm",
      ),
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
      id: '123454',
      type: RequisitionTypeEnum.explanation,
      status: StatusRequisitionEnum.expired,
      title: "Hôm nay tôi nghỉ",
      content: RequisitionExplanation(
        reason: 'Lý do cá nhân',
        reasonForExplanation: "Xin đi muộn",
        detailedDescription: "Xe máy hỏng",
        totalMinute: 123,
      ),
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
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsInit));
    try {
      List<Requisition> requisitionsByFilter = state.requisitions;

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
