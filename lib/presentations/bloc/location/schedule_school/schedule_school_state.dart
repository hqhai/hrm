import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'schedule_school_state.g.dart';

@CopyWith()
class ScheduleSchoolState extends Equatable {
  final ScheduleSchools scheduleSchools;

  const ScheduleSchoolState({
    this.scheduleSchools = const ScheduleSchools(),
  });

  @override
  List<Object> get props => [scheduleSchools];
}
