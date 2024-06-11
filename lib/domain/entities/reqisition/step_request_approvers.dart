import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'step_request_approvers.g.dart';

@CopyWith()
@JsonSerializable()
class StepRequestApprovers {
  final String id;
  final String? createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final String? note;
  final EnumStepRequestStatusEnum? status;
  final String? stepRequestId;
  final String? approverId;
  final String? approverPositionId;
  final String? approverDepartmentId;

  const StepRequestApprovers({
    required this.id,
    this.status,
    this.note,
    this.createdUserId,
    this.createdFullName,
    this.createdDate,
    this.updatedFullName,
    this.updatedDate,
    this.updatedUserId,
    this.approverId,
    this.approverDepartmentId,
    this.approverPositionId,
    this.stepRequestId,
  });

  factory StepRequestApprovers.fromJson(Map<String, dynamic> json) =>
      _$StepRequestApproversFromJson(json);

  Map<String, dynamic> toJson() => _$StepRequestApproversToJson(this);
}
