import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:bloc/bloc.dart';

import 'package:injectable/injectable.dart';

@lazySingleton
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase _attendanceUseCase;

  AttendanceBloc()
      : _attendanceUseCase = dI<AttendanceUseCase>(),
        super(const AttendanceState()) {
    on<AttendanceEvent>((event, emit) {});
    on<GetAttendanceEvent>(_getAttendanceEvent);
  }

  FutureOr<void> _getAttendanceEvent(
      GetAttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: AttendanceStatus.getAttendanceInit));
    try {
      if (event.month == 12) {
        List<Attendance> attendances = await _attendanceUseCase.getAttendances(
            email: event.email,
            endDate: formatYM(event.year + 1, 1),
            startDate: formatYM(event.year, event.month));
        emit(state.copyWith(
            attendances: attendances, status: AttendanceStatus.getAttendanceSuccess));
      } else {
        List<Attendance> attendances = await _attendanceUseCase.getAttendances(
            email: event.email,
            endDate: formatYM(event.year, event.month + 1),
            startDate: formatYM(event.year, event.month));
        emit(state.copyWith(
            attendances: attendances, status: AttendanceStatus.getAttendanceSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.getAttendanceError));
    }
  }
}
