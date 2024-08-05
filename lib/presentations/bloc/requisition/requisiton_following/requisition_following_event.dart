import 'dart:async';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionFollowingEvent extends Equatable {
  const RequisitionFollowingEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsFollowingByFilterEvent extends RequisitionFollowingEvent {
  final int? page;
  final List<RequisitionTypeEnum>? type;
  final String? userIds;
  final String? departmentId;
  final StatusRequestEnum? status;
  final DateTime? startTime;
  final DateTime? endTime;
  final Completer? completer;

  const GetRequisitionsFollowingByFilterEvent({
    this.type,
    this.userIds,
    this.departmentId,
    this.status,
    this.completer,
    this.startTime,
    this.endTime,
    this.page,
  });

  @override
  List<Object?> get props =>
      [startTime, endTime, page, type, userIds, departmentId, status, completer];
}
