import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_school.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class ScheduleSchool {
  final int startTime;
  final int endTime;
  final String teacherName;
  final String className;
  final String description;
  final School school;
  final String id;

  const ScheduleSchool(
      {this.id = '',
      this.startTime = 0,
      this.endTime = 0,
      this.description = '',
      this.school = const School(),
      this.className = '',
      this.teacherName = '',});

  factory ScheduleSchool.fromJson(Map<String, dynamic> json) => _$ScheduleSchoolFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSchoolToJson(this);
}
