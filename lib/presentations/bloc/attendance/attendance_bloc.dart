import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
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
    on<GetAttendanceNowEvent>(_getAttendanceNowEvent);
  }

  FutureOr<void> _getAttendanceEvent(
      GetAttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: AttendanceStatus.getAttendanceInit));
    try {
      Attendance attendance = await _attendanceUseCase.getAttendances(
          id: event.id, year: event.year.toString(), month: event.month.toString());
      emit(state.copyWith(
          attendance: attendance,
          status: AttendanceStatus.getAttendanceSuccess));
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
}
