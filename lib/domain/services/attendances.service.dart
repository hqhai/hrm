import 'package:base_app/data/models/request/attendances/get_attendance_request.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/data/models/work_and_salary/work_sheet_history_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';

abstract class AttendanceService {
  Future<Attendance> workSheet(GetAttendanceRequest getAttendanceRequest);

  Future<Attendance> getAttendance(GetAttendancesRequest getAttendanceRequest);

  Future<WorkSheet> getWorkSheet({required GetWorkSheetRequest time});

  Future<List<AttendanceByDate>> getAttendancesByDate({required WorkSheetHistoryRequest workSheetHistoryRequest});
}
