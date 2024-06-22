import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_over_time.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionOverTime {
  final String? date;
  final int? startTime;
  final int? endTime;
  final double? suggestTime;
  final String? note;

  const RequisitionOverTime({
    this.endTime,
    this.startTime,
    this.note,
    this.date,
    this.suggestTime
  });

  factory RequisitionOverTime.fromJson(Map<String, dynamic> json) =>
      _$RequisitionOverTimeFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionOverTimeToJson(this);
}
