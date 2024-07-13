import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:base_app/domain/services/attendances.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImplement extends AttendanceRepository {
  final AttendanceService attendanceService;

  AttendanceRepositoryImplement() : attendanceService = dI<AttendanceService>();

  @override
  Future<Attendance> getAttendances(
      {required String month, required String year, required String id}) async {
    final attendances = await attendanceService
        .getAttendance(GetAttendanceRequest(month: month, year: year, userid: id));
    return attendances;
  }

  @override
  Future<WorkSheet> getWorkSheet({required DateTime time}) async {
    return await attendanceService.getWorkSheet(time: GetWorkSheetRequest(time: time));
  }
}
