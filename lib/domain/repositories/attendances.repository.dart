import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_list_date.dart';

abstract class AttendanceRepository {
  Future<Attendance?> workSheet({
    required DateTime startTime,
    required DateTime endTime,
  });

  Future<WorkSheet?> getWorkSheet({required DateTime time});

  Future<Attendance?> getAttendance({
    required String month,
    required String year,
    required String id,
  });

  Future<List<AttendanceByDate>?> getAttendancesByDate(
      {required DateTime time, required String userId});

  Future<List<AttendanceByListDate>?> getAttendanceByListDate({
    required List<String> dates,
    required String userId,
  });
}
