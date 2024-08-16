import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_over_time.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionOverTime {
  final DateTime? date;
  final int? startTime;
  final int? endTime;
  final double? suggestTime;
  final String? note;
  final EnumOvertimeDay? overTimeDay;
  final bool isChecking;

  const RequisitionOverTime({
    this.endTime,
    this.startTime,
    this.note,
    this.date,
    this.suggestTime,
    this.overTimeDay,
    this.isChecking = true,
  });

  factory RequisitionOverTime.fromJson(Map<String, dynamic> json) =>
      _$RequisitionOverTimeFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionOverTimeToJson(this);
}
