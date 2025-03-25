import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/attendances/get_attendance_request.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/data/models/work_and_salary/work_sheet_history_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_list_date.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/attendances_service.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImplement extends AttendanceRepository {
  final AttendanceService _attendanceService;

  AttendanceRepositoryImplement(this._attendanceService);

  @override
  Future<Attendance?> workSheet({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final attendances = await _attendanceService.workSheet(
        GetAttendanceRequest(startDate: startTime, endDate: endTime));
    return attendances?.data;
  }

  @override
  Future<WorkSheet> getWorkSheet({required DateTime time}) async {
    return await _attendanceService.getWorkSheet(
        time: GetWorkSheetRequest(time: time));
  }

  @override
  Future<Attendance?> getAttendance(
      {required String month, required String year, required String id}) async {
    final attendances = await _attendanceService.getAttendance(
        GetAttendancesRequest(month: month, year: year, userid: id));
    return attendances?.data;
  }

  @override
  Future<List<AttendanceByDate>?> getAttendancesByDate(
      {required DateTime time}) async {
    final id = dI<UserBloc>().state.user.id;
    final data = await _attendanceService.getAttendancesByDate(
        workSheetHistoryRequest: WorkSheetHistoryRequest(
      date: time,
      userId: id,
    ));
    return data?.result;
  }

  @override
  Future<List<AttendanceByListDate>?> getAttendanceByListDate(
      {required List<String> dates, required String userId}) async {
    final data = await _attendanceService.getAttendanceByListDate(
      dates: dates,
      userId: userId,
    );
    return data?.result;
  }
}
