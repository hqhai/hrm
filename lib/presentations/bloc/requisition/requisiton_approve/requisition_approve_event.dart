import 'dart:async';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionApproveEvent extends Equatable {
  const RequisitionApproveEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsApproveByFilterEvent extends RequisitionApproveEvent {
  const GetRequisitionsApproveByFilterEvent(
      {this.requisitionTypeEnum,
      this.startTime,
      this.endTime,
      this.page = 0,
      this.departmentId,
      this.status,});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final DateTime? startTime;
  final DateTime? endTime;
  final int page;
  final String? departmentId;
  final String? status;

  @override
  List<Object?> get props => [requisitionTypeEnum, startTime, endTime, page, departmentId, status];
}

class GetRequisitionApproveByIdEvent extends RequisitionApproveEvent {
  const GetRequisitionApproveByIdEvent({this.requisition});

  final Request? requisition;

  @override
  List<Object?> get props => [requisition];
}

class ApproveRequestEvent extends RequisitionApproveEvent {
  final String id;
  final String? note;
  final EnumStepRequestStatusEnum? status;
  final String requestId;
  final Completer completer;

  const ApproveRequestEvent({
    this.id = '',
    this.note,
    this.status,
    this.requestId = '',
    required this.completer
  });

  @override
  List<Object?> get props => [id, note, status, requestId, completer];
}
