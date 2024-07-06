import 'dart:async';

import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:equatable/equatable.dart';

sealed class LeaveHistoryEvent extends Equatable {
  const LeaveHistoryEvent();

  @override
  List<Object?> get props => [];
}

class GetLeaveHistoryEvent extends LeaveHistoryEvent {
  final DateTime? time;
  final int page;
  final TypeLeaveEnum? type;
  final Completer? completer;

  const GetLeaveHistoryEvent({
    this.page = 1,
    this.time,
    this.type,
    this.completer,
  });

  @override
  List<Object?> get props => [
        page,
        time,
        type,
        completer,
      ];
}
