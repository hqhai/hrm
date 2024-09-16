import 'dart:async';

import 'package:equatable/equatable.dart';

sealed class ShiftEvent extends Equatable {
  const ShiftEvent();

  @override
  List<Object?> get props => [];
}

class GetShiftByIdEvent extends ShiftEvent {
  final String id;
  final Completer? completer;

  const GetShiftByIdEvent({
    this.id = '',
    this.completer,
  });

  @override
  List<Object?> get props => [id, completer];
}

class GetShiftByIdsEvent extends ShiftEvent {
  final List<String> ids;
  final Completer? completer;

  const GetShiftByIdsEvent({
    this.ids = const [],
    this.completer,
  });

  @override
  List<Object?> get props => [ids, completer];
}

class ResetShiftEvent extends ShiftEvent {
  const ResetShiftEvent();

  @override
  List<Object> get props => [];
}
