import 'package:equatable/equatable.dart';

sealed class WorkAndSalaryEvent extends Equatable {
  const WorkAndSalaryEvent();

  @override
  List<Object?> get props => [];
}

class GetTotalLeaveDayEvent extends WorkAndSalaryEvent {
  const GetTotalLeaveDayEvent();

  @override
  List<Object?> get props => [];
}

class GetTotalWorkdayEvent extends WorkAndSalaryEvent {
  final String startTime, endTime;

  const GetTotalWorkdayEvent({this.startTime = '', this.endTime = ''});

  @override
  List<Object?> get props => [startTime, endTime];
}
