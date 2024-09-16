import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/use_cases/work_and_salary.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LeaveShiftBloc extends HydratedBloc<LeaveShiftEvent, LeaveShiftState> {
  final WorkAndSalaryUseCase _workAndSalaryUseCase;

  LeaveShiftBloc()
      : _workAndSalaryUseCase = dI<WorkAndSalaryUseCase>(),
        super(const LeaveShiftState()) {
    on<LeaveShiftEvent>((event, emit) {});
    on<GetWorkShiftsEvent>(_getWorkShiftsEvent);
    on<GetWorkShiftsExplanationEvent>(_getWorkShiftsExplanationEvent);
    on<ResetLeaveShiftEvent>(_resetLeaveShiftEvent);
  }

  FutureOr<void> _getWorkShiftsEvent(
      GetWorkShiftsEvent event, Emitter<LeaveShiftState> emit) async {
    try {
      final response = await _workAndSalaryUseCase.workShiftLeave(
          startTime: event.startDate, endTime: event.endDate);
      final map = response.mapWorkShift;
      final keys = response.keys;
      final keyDates = response.mapKeyDate;
      emit(state.copyWith(
        mapKeyDate: keyDates,
        keys: keys,
        workShifts: map,
      ));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getWorkShiftsExplanationEvent(
      GetWorkShiftsExplanationEvent event, Emitter<LeaveShiftState> emit) async {
    try {
      final response = await _workAndSalaryUseCase.workShiftExplanation();
      final map = response.mapWorkShift;
      final keys = response.keys;
      final keyDates = response.mapKeyDate;
      emit(state.copyWith(
        mapKeyDate: keyDates,
        keys: keys,
        workShifts: map,
      ));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  @override
  LeaveShiftState? fromJson(Map<String, dynamic> json) {
    return LeaveShiftState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LeaveShiftState state) {
    return state.toJson();
  }

  FutureOr<void> _resetLeaveShiftEvent(ResetLeaveShiftEvent event, Emitter<LeaveShiftState> emit) {
    emit(const LeaveShiftState());
  }
}
