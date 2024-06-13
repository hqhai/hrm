

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionApproveEvent extends Equatable {
  const RequisitionApproveEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsApproveEvent extends RequisitionApproveEvent {
  const GetRequisitionsApproveEvent({this.page = 0});
  final int page;

  @override
  List<Object?> get props => [page];
}

class GetRequisitionsApproveByFilterEvent extends RequisitionApproveEvent {
  const GetRequisitionsApproveByFilterEvent(
      {this.requisitionTypeEnum, this.listStatusRequisition, this.startTime, this.endTime, this.page = 0});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequestEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;
  final int page;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime, page];
}

class GetRequisitionApproveByIdEvent extends RequisitionApproveEvent {
  const GetRequisitionApproveByIdEvent({this.requisition});

  final Request? requisition;

  @override
  List<Object?> get props => [requisition];
}
