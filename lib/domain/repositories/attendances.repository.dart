import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';

abstract class AttendanceRepository {
  Future<Attendance> getAttendances({
    required String month,
    required String year,
    required String id,
  });

  Future<WorkSheet> getWorkSheet({
    required DateTime time
  });
}
