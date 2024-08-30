import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/check_in_check_out.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_schools.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class ScheduleSchools {
  final List<CheckInCheckOut> timeUnits;
  final List<ScheduleSchool> scheduleSchools;

  const ScheduleSchools({
    this.scheduleSchools = const [],
    this.timeUnits = const [],
  });

  factory ScheduleSchools.fromJson(Map<String, dynamic> json) => _$ScheduleSchoolsFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSchoolsToJson(this);
}
