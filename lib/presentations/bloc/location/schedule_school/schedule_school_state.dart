import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_school_state.g.dart';

@CopyWith()
@JsonSerializable()
class ScheduleSchoolState extends Equatable {
  final ScheduleSchools scheduleSchools;

  const ScheduleSchoolState({
    this.scheduleSchools = const ScheduleSchools(),
  });

  @override
  List<Object> get props => [scheduleSchools];

  factory ScheduleSchoolState.fromJson(Map<String, dynamic> json) =>
      _$ScheduleSchoolStateFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleSchoolStateToJson(this);
}
