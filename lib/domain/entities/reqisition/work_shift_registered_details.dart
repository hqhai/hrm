import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shift_registered_details.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
///Ca làm việc
class WorkShiftRegisteredDetail {
  final String workShiftSettingDetailId;
  final DateTime workDate;
  final int workEffort;
  final String nameWorkShift;
  final int startTime;
  final int endTime;

  const WorkShiftRegisteredDetail({
    this.workShiftSettingDetailId = '',
    required this.workDate,
    this.workEffort = 0,
    this.nameWorkShift = '',
    this.endTime = 0,
    this.startTime = 0,
  });

  factory WorkShiftRegisteredDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftRegisteredDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftRegisteredDetailToJson(this);
}
