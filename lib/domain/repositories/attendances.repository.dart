import 'package:base_app/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getAttendances({
    required String month,
    required String year,
    required String id,
  });
}
