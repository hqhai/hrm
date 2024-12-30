import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AttendanceBloc extends HydratedBloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase _attendanceUseCase;

  AttendanceBloc(this._attendanceUseCase) : super(const AttendanceState()) {
    on<AttendanceEvent>((event, emit) {});
    on<GetAttendanceEvent>(_getAttendanceEvent);
    on<GetAttendanceNowEvent>(_getAttendanceNowEvent);
    on<GetWorkSheetEvent>(_getWorkSheetEvent);
    on<ResetAttendanceEvent>(_resetAttendanceEvent);
  }

  FutureOr<void> _getAttendanceEvent(
      GetAttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: AttendanceStatus.getAttendanceInit));
    try {
      Attendance? attendance = await _attendanceUseCase.getAttendance(
          id: event.id,
          year: event.year.toString(),
          month: event.month.toString());
      if (attendance != null) {
        emit(state.copyWith(
            attendance: attendance,
            status: AttendanceStatus.getAttendanceSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.getAttendanceError));
    }
  }

  FutureOr<void> _getAttendanceNowEvent(
      GetAttendanceNowEvent event, Emitter<AttendanceState> emit) async {
    /* emit(state.copyWith(status: AttendanceStatus.getAttendanceInit));
    try {
      DateTime dateDime = DateTime.now();
      String time = DateFormat('yyyy-MM-dd').format(dateDime);
      List<Attendance> attendancesNow = await _attendanceUseCase.getAttendances(
          id: event.id, year: dateDime.year.toString(), month: dateDime.month.toString());
      Attendance attendanceNow =
          attendancesNow.where((e) => formatYMD(e.attendanceDate.toString()).contains(time)).first;
      emit(
          state.copyWith(attendance: attendanceNow, status: AttendanceStatus.getAttendanceSuccess));
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.getAttendanceError));
    }*/
  }

  Future<FutureOr<void>> _getWorkSheetEvent(
      GetWorkSheetEvent event, Emitter<AttendanceState> emit) async {
    try {
      Attendance? attendance = await _attendanceUseCase.workSheet(
          endTime: event.endTime, startTime: event.startTime);

      if (attendance != null) {
        emit(state.copyWith(
            attendance: attendance,
            status: AttendanceStatus.getAttendanceSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.getAttendanceError));
    }
  }

  FutureOr<void> _resetAttendanceEvent(
      ResetAttendanceEvent event, Emitter<AttendanceState> emit) {
    emit(const AttendanceState());
  }

  @override
  AttendanceState? fromJson(Map<String, dynamic> json) {
    return AttendanceState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AttendanceState state) {
    return state.toJson();
  }
}
