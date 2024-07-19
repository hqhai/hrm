import 'package:base_app/data/models/request/attendances/get_attendance_request.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';

abstract class AttendanceService {
  Future<Attendance> workSheet(GetAttendanceRequest getAttendanceRequest);

  Future<Attendance> getAttendance(GetAttendancesRequest getAttendanceRequest);

  Future<WorkSheet> getWorkSheet({required GetWorkSheetRequest time});
}
