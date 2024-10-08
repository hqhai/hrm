import 'package:base_app/common/enum/boundary_status.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/requisition/step_request_approvers.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'step_requests.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class StepRequests {
  final String id;
  final String? createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final int? visitCount;
  @JsonKey(unknownEnumValue: EnumStepRequestStatusEnum.unknown)
  final EnumStepRequestStatusEnum status;
  final String? requestId;
  final String? stepFlowId;
  final List<StepRequestApprovers> stepRequestApprovers;
  @JsonKey(unknownEnumValue: EnumBoundaryStatus.unknown)
  final EnumBoundaryStatus boundaryStatus;

  const StepRequests(
      {required this.id,
      this.createdUserId,
      this.createdFullName,
      this.createdDate,
      this.updatedFullName,
      this.updatedDate,
      this.updatedUserId,
      this.visitCount,
      this.status = EnumStepRequestStatusEnum.unknown,
      this.requestId,
      this.stepFlowId,
      this.stepRequestApprovers = const [],
      this.boundaryStatus = EnumBoundaryStatus.unknown});

  factory StepRequests.fromJson(Map<String, dynamic> json) =>
      _$StepRequestsFromJson(json);

  Map<String, dynamic> toJson() => _$StepRequestsToJson(this);
}
