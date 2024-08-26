import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition/step_flow.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow.g.dart';

@CopyWith()
@JsonSerializable()
class FlowRequest {
  final RequisitionTypeEnum? flowType;
  final String? name;
  final int? timeLimitBeforeCreation;
  final int? timeLimitAfterCreation;
  final int? timeLimitApproval;
  final int? timeLimitEdit;
  final int? quantityLimit;
  final String? quantityLimitType;
  final String id;
  final List<StepFlow> stepFlows;

  const FlowRequest({
    required this.id,
    this.flowType,
    this.name,
    this.timeLimitBeforeCreation,
    this.timeLimitAfterCreation,
    this.timeLimitApproval,
    this.timeLimitEdit,
    this.quantityLimit,
    this.quantityLimitType,
    this.stepFlows = const [],

  });

  factory FlowRequest.fromJson(Map<String, dynamic> json) => _$FlowRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FlowRequestToJson(this);
}
