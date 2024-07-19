import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class WorkDayEvent extends Equatable {
  const WorkDayEvent();

  @override
  List<Object?> get props => [];
}

class GetWorkDaysEvent extends WorkDayEvent {
  final DateTime startDate;
  final DateTime endDate;
  final Completer? completer;

  const GetWorkDaysEvent({
    this.completer,
    required this.endDate,
    required this.startDate,
  });

  @override
  List<Object?> get props => [
        completer,
        endDate,
        startDate,
      ];
}
