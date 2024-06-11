import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/step_requests.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow.g.dart';

@CopyWith()
@JsonSerializable()
class Flow {
  final RequisitionTypeEnum? flowType;
  final String? name;
  final int? timeLimitBeforeCreation;
  final int? timeLimitAfterCreation;
  final int? timeLimitApproval;
  final int? timeLimitEdit;
  final int? quantityLimit;
  final String? quantityLimitType;
  final String id;

  const Flow({
    this.flowType,
    this.name,
    this.timeLimitBeforeCreation,
    this.timeLimitAfterCreation,
    this.timeLimitApproval,
    this.timeLimitEdit,
    this.quantityLimit,
    this.quantityLimitType,
    required this.id,
  });

  factory Flow.fromJson(Map<String, dynamic> json) => _$FlowFromJson(json);

  Map<String, dynamic> toJson() => _$FlowToJson(this);
}
