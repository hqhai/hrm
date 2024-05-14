import 'package:base_app/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<List<Attendance>> getAttendances({
    required String startDate,
    required String endDate,
    required String email,
  });
}
