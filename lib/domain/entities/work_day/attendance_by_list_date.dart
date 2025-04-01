// AttendanceByListDate
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_by_list_date.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class AttendanceByListDate {
  final DateTime date;
  final List<AttendanceByDate> checkings;

  AttendanceByListDate({
    required this.date,
    this.checkings = const [],
  });

  factory AttendanceByListDate.fromJson(Map<String, dynamic> json) =>
      _$AttendanceByListDateFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceByListDateToJson(this);
}
