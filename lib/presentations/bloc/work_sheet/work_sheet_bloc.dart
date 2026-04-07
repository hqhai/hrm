import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WorkSheetBloc extends HydratedBloc<WorkSheetEvent, WorkSheetState> {
  final AttendanceUseCase _attendanceUseCase;

  WorkSheetBloc()
      : _attendanceUseCase = dI<AttendanceUseCase>(),
        super(const WorkSheetState()) {
    on<GetWorkSheetEvent>(_getWorkSheetEvent);
    on<GetAttendancesByDateEvent>(_getAttendancesByDateEvent);
    on<ResetWorkSheetEvent>(_resetWorkSheetEvent);
    on<GetAttendanceByListDateEvent>(_getAttendanceByListDateEvent);
  }

  FutureOr<void> _getWorkSheetEvent(
      GetWorkSheetEvent event, Emitter<WorkSheetState> emit) async {
    try {
      final workSheet = await _attendanceUseCase.getWorkSheet(time: event.time);
      emit(state.copyWith(workSheet: workSheet));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getAttendancesByDateEvent(
      GetAttendancesByDateEvent event, Emitter<WorkSheetState> emit) async {
    try {
      final workSheet =
          await _attendanceUseCase.getAttendancesByDate(time: event.date, userId: event.userId);
      if (workSheet != null) {
        emit(state.copyWith(
          attendances: workSheet.attendances,
          keys: workSheet.keys,
        ));
      }

      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  @override
  WorkSheetState? fromJson(Map<String, dynamic> json) {
    return WorkSheetState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WorkSheetState state) {
    return state.toJson();
  }

  FutureOr<void> _resetWorkSheetEvent(
      ResetWorkSheetEvent event, Emitter<WorkSheetState> emit) {
    emit(const WorkSheetState());
  }

  FutureOr<void> _getAttendanceByListDateEvent(
      GetAttendanceByListDateEvent event, Emitter<WorkSheetState> emit) async {
    final attendanceByListDates =
        await _attendanceUseCase.getAttendanceByListDate(
      dates: event.dates,
      userId: event.userId,
    );
    emit(state.copyWith(
      attendanceByListDates: attendanceByListDates,
    ));
  }
}
