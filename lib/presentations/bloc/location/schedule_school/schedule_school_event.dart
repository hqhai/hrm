import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class ScheduleSchoolEvent extends Equatable {
  const ScheduleSchoolEvent();

  @override
  List<Object?> get props => [];
}

class GetScheduleSchoolEvent extends ScheduleSchoolEvent {
  final DateTime dateTime;
  final Completer? completer;

  const GetScheduleSchoolEvent({required this.dateTime, this.completer});

  @override
  List<Object?> get props => [dateTime, completer];
}
