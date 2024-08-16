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
  final int? page;
  final List<RequisitionTypeEnum>? type;
  final String? userIds;
  final String? departmentId;
  final EnumStepRequestStatusEnum? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final Completer? completer;

  const GetRequisitionsApproveByFilterEvent(
      {this.startTime,
      this.endTime,
      this.page = 1,
      this.departmentId,
      this.status,
      this.type,
      this.completer,
      this.userIds});

  @override
  List<Object?> get props =>
      [startTime, endTime, page, departmentId, status, userIds, completer, type];
}

class GetRequisitionApproveByIdEvent extends RequisitionApproveEvent {
  const GetRequisitionApproveByIdEvent({this.requisition});

  final Request? requisition;

  @override
  List<Object?> get props => [requisition];
}

class GetRequisitionApproveCountEvent extends RequisitionApproveEvent {
  const GetRequisitionApproveCountEvent();

  @override
  List<Object?> get props => [];
}

class ApproveRequestEvent extends RequisitionApproveEvent {
  final String id;
  final String? note;
  final EnumStepRequestStatusEnum? status;
  final String requestId;
  final Completer? completer;

  const ApproveRequestEvent(
      {this.id = '', this.note, this.status, this.requestId = '', this.completer});

  @override
  List<Object?> get props => [id, note, status, requestId, completer];
}

class CancelRequestEvent extends RequisitionApproveEvent {
  final String requestId;
  final Completer? completer;

  const CancelRequestEvent({this.requestId = '', this.completer});

  @override
  List<Object?> get props => [requestId, completer];
}
