import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/domain/entities/attendance.dart';

abstract class AttendanceService {
  Future<List<Attendance>> getAttendance(GetAttendanceRequest getAttendanceRequest);
}
