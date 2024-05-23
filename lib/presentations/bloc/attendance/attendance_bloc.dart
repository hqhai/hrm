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
import 'package:intl/intl.dart';

@lazySingleton
class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase _attendanceUseCase;

  AttendanceBloc()
      : _attendanceUseCase = dI<AttendanceUseCase>(),
        super(const AttendanceState()) {
    on<AttendanceEvent>((event, emit) {});
    on<GetAttendanceEvent>(_getAttendanceEvent);
  }

  FutureOr<void> _getAttendanceEvent(GetAttendanceEvent event,
      Emitter<AttendanceState> emit) async {
    emit(state.copyWith(status: AttendanceStatus.getAttendanceInit));
    try {
      List<Attendance> attendances = await _attendanceUseCase.getAttendances(
          id: event.id,
          year: event.year.toString(),
          month: event.month.toString());
      /*Attendance attendance = attendances
          .where((e) =>
      formatYMD(e.attendanceDate) == DateFormat('yyyy-MM-dd').format(DateTime.now()))
          .first;
      if (attendance.attendanceDate.isNotEmpty) {
        emit(state.copyWith(attendance: attendance,
            attendances: attendances, status: AttendanceStatus.getAttendanceSuccess));
      }
      else {
        emit(state.copyWith(
            attendances: attendances, status: AttendanceStatus.getAttendanceSuccess));
      }*/
      emit(state.copyWith(
          attendances: attendances, status: AttendanceStatus.getAttendanceSuccess));
    } catch (e) {
      emit(state.copyWith(status: AttendanceStatus.getAttendanceError));
    }
  }
}
