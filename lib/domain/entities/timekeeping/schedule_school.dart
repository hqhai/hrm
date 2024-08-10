import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_school.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class ScheduleSchool {
  final DateTime? workDate;
  final int? startTime;
  final int? endTime;
  final String teacherName;
  final String className;
  final String description;
  final School? school;
  final String id;

  const ScheduleSchool({
    this.id = '',
    this.startTime,
    this.endTime,
    this.description = '',
    this.school,
    this.workDate,
    this.className = '',
    this.teacherName = '',
  });

  factory ScheduleSchool.fromJson(Map<String, dynamic> json) => _$ScheduleSchoolFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSchoolToJson(this);
}
