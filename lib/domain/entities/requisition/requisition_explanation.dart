import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_explanation.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionExplanation {
  final String? reason;
  final String? reasonForExplanation;
  final String? detailedDescription;
  final int? totalMinute;

  const RequisitionExplanation({
    this.reason,
    this.reasonForExplanation,
    this.detailedDescription,
    this.totalMinute
  });

  factory RequisitionExplanation.fromJson(Map<String, dynamic> json) =>
      _$RequisitionExplanationFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionExplanationToJson(this);
}
