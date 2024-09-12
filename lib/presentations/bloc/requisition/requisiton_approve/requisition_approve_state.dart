import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_approve_state.g.dart';

const statusCountDefault = {
  EnumStepRequestStatusEnum.newStatus: 0,
  EnumStepRequestStatusEnum.reject: 0,
  EnumStepRequestStatusEnum.edit: 0,
  EnumStepRequestStatusEnum.approve: 0,
  EnumStepRequestStatusEnum.cancel: 0,
  EnumStepRequestStatusEnum.overdueApprove: 0,
};

@CopyWith()
@JsonSerializable()
class RequisitionApproveState extends Equatable {
  final Request requisition;
  final Map<String, Request> requisitions;
  final List<String> requisitionIds;
  final Map<EnumStepRequestStatusEnum, int> statusRequestCount;
  final String errorCode;
  final int countItem;

  const RequisitionApproveState({
    this.requisition = const Request(id: ''),
    this.requisitions = const {},
    this.requisitionIds = const [],
    this.statusRequestCount = statusCountDefault,
    this.countItem = 0,
    this.errorCode = '',
  });

  @override
  List<Object> get props => [
        requisition,
        requisitions,
        requisitionIds,
        countItem,
        errorCode,
        statusRequestCount.hashCode
      ];

  factory RequisitionApproveState.fromJson(Map<String, dynamic> json) => _$RequisitionApproveStateFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionApproveStateToJson(this);
}
