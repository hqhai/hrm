import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_by_date.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class AttendanceByDate {
  final DateTime timeChecking;
  final bool status;
  final CheckInMethodEnum checkInMethod;

  const AttendanceByDate({
    required this.timeChecking,
    this.status = false,
    this.checkInMethod = CheckInMethodEnum.none,
  });

  factory AttendanceByDate.fromJson(Map<String, dynamic> json) => _$AttendanceByDateFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceByDateToJson(this);
}
