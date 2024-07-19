import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';

abstract class AttendanceUseCase {
  Future<Attendance> workSheet({
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<Attendance> getAttendance({
    required String month,
    required String year,
    required String id,
  });

  Future<WorkSheet> getWorkSheet({required DateTime time});
}
