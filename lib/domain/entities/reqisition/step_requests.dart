import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/step_request_approvers.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'step_requests.g.dart';

@CopyWith()
@JsonSerializable()
class StepRequests {
  final String id;
  final String? createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final int? visitCount;
  final EnumStepRequestStatusEnum? status;
  final String? requestId;
  final String? stepFlowId;
  final List<StepRequestApprovers>? stepRequestApprovers;

  const StepRequests(
      {required this.id,
      this.createdUserId,
      this.createdFullName,
      this.createdDate,
      this.updatedFullName,
      this.updatedDate,
      this.updatedUserId,
      this.visitCount,
      this.status,
      this.requestId,
      this.stepFlowId,
      this.stepRequestApprovers});

  factory StepRequests.fromJson(Map<String, dynamic> json) => _$StepRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$StepRequestsToJson(this);
}
