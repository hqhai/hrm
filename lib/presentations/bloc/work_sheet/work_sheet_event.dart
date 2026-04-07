import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class WorkSheetEvent extends Equatable {
  const WorkSheetEvent();

  @override
  List<Object?> get props => [];
}

class GetWorkSheetEvent extends WorkSheetEvent {
  final DateTime time;
  final Completer? completer;

  const GetWorkSheetEvent({required this.time, this.completer});

  @override
  List<Object?> get props => [time, completer];
}

class GetAttendancesByDateEvent extends WorkSheetEvent {
  final DateTime date;
  final String userId;
  final Completer? completer;

  const GetAttendancesByDateEvent({
    required this.date,
    required this.userId,
    this.completer,
  });

  @override
  List<Object?> get props => [date, userId, completer];
}

class ResetWorkSheetEvent extends WorkSheetEvent {
  const ResetWorkSheetEvent();

  @override
  List<Object> get props => [];
}

class GetAttendanceByListDateEvent extends WorkSheetEvent {
  final List<String> dates;
  final String userId;
  const GetAttendanceByListDateEvent({
    required this.dates,
    required this.userId,
  });

  @override
  List<Object> get props => [dates, userId];
}
