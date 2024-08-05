import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'schedule_school_state.g.dart';

@CopyWith()
class ScheduleSchoolState extends Equatable {
  final ScheduleSchool scheduleSchool;

  const ScheduleSchoolState({
    this.scheduleSchool = const ScheduleSchool(),
  });

  @override
  List<Object> get props => [scheduleSchool];
}
