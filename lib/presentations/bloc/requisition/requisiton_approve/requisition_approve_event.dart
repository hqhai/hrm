

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/requisition.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionApproveEvent extends Equatable {
  const RequisitionApproveEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsApproveEvent extends RequisitionApproveEvent {
  const GetRequisitionsApproveEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsApproveByFilterEvent extends RequisitionApproveEvent {
  const GetRequisitionsApproveByFilterEvent(
      {this.requisitionTypeEnum, this.listStatusRequisition, this.startTime, this.endTime});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequisitionEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime];
}

class GetRequisitionApproveByIdEvent extends RequisitionApproveEvent {
  const GetRequisitionApproveByIdEvent({this.requisition});

  final Requisition? requisition;

  @override
  List<Object?> get props => [requisition];
}
