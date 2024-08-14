import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class WorkAndSalaryEvent extends Equatable {
  const WorkAndSalaryEvent();

  @override
  List<Object?> get props => [];
}

class GetTotalLeaveDayEvent extends WorkAndSalaryEvent {
  final Completer? completer;
  const GetTotalLeaveDayEvent({this.completer});


  @override
  List<Object?> get props => [completer];
}

class GetTotalWorkdayEvent extends WorkAndSalaryEvent {
  final String startTime, endTime;

  const GetTotalWorkdayEvent({this.startTime = '', this.endTime = ''});

  @override
  List<Object?> get props => [startTime, endTime];
}
