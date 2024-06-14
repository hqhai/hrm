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
      {this.requisitionTypeEnum,
      this.startTime,
      this.endTime,
      this.page = 0,
      this.departmentId,
      this.status});

  final RequisitionTypeEnum? requisitionTypeEnum;
  final String? startTime;
  final String? endTime;
  final int page;
  final String? departmentId;
  final String? status;

  @override
  List<Object?> get props => [requisitionTypeEnum, startTime, endTime, page, departmentId, status];
}

class RemoveFilterEvent extends RequisitionApproveEvent {
  const RemoveFilterEvent({this.status = ''});
  final String status;
  @override
  List<Object?> get props => [status];
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

  const ApproveRequestEvent({
    this.id = '',
    this.note,
    this.status,
  });

  @override
  List<Object?> get props => [id, note, status];
}
