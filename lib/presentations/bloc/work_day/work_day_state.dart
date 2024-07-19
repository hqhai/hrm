import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'work_day_state.g.dart';

@CopyWith()
class WorkDayState extends Equatable {
  final Map<String, WorkDay> workDays;
  final List<String> workDayIds;

  const WorkDayState({
    this.workDays = const {},
    this.workDayIds = const [],
  });

  @override
  List<Object> get props => [];
}
