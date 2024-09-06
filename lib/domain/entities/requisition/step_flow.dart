import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'step_flow.g.dart';

@CopyWith()
@JsonSerializable()
class StepFlow {
  final String id;
  final String flowId;
  final String positionId;
  final String userId;
  final String userName;
  final String departmentId;
  final int level;
  final String name;
  @JsonKey(unknownEnumValue: EnumStepFlowType.unknown)
  final EnumStepFlowType type;
  final String parentId;

  const StepFlow({
    required this.id,
    required this.flowId,
    this.userName = '',
    this.type = EnumStepFlowType.unknown,
    this.userId = '',
    this.positionId = '',
    this.departmentId = '',
    this.name = '',
    this.parentId = '',
    this.level = 1,
  });

  factory StepFlow.fromJson(Map<String, dynamic> json) => _$StepFlowFromJson(json);

  Map<String, dynamic> toJson() => _$StepFlowToJson(this);
}
