import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class LeaveShiftEvent extends Equatable {
  const LeaveShiftEvent();

  @override
  List<Object?> get props => [];
}

class GetWorkShiftsEvent extends LeaveShiftEvent {
  final DateTime startDate;
  final DateTime endDate;
  final Completer? completer;

  const GetWorkShiftsEvent({required this.startDate, required this.endDate, this.completer});

  @override
  List<Object?> get props => [startDate, endDate, completer];
}

class GetWorkShiftsExplanationEvent extends LeaveShiftEvent {
  final Completer? completer;

  const GetWorkShiftsExplanationEvent({this.completer});

  @override
  List<Object?> get props => [completer];
}
