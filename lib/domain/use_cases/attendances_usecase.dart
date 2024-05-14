import 'package:base_app/domain/entities/attendance.dart';

abstract class AttendanceUseCase {
  Future<List<Attendance>> getAttendances({
    required String startDate,
    required String endDate,
    required String email,
  });
}
