import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:equatable/equatable.dart';

sealed class RequisitionEvent extends Equatable {
  const RequisitionEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsEvent extends RequisitionEvent {
  const GetRequisitionsEvent();

  @override
  List<Object?> get props => [];
}

class GetRequisitionsByFilterEvent extends RequisitionEvent {
  const GetRequisitionsByFilterEvent(
      {this.requisitionTypeEnum,
      this.listStatusRequisition,
      this.startTime,
      this.endTime});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final List<StatusRequisitionEnum>? listStatusRequisition;
  final String? startTime;
  final String? endTime;

  @override
  List<Object?> get props => [requisitionTypeEnum, listStatusRequisition, startTime, endTime];
}
