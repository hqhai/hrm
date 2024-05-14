import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:base_app/domain/services/attendances.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AttendanceRepository)
class AttendanceRepositoryImplement extends AttendanceRepository {
  final AttendanceService attendanceService;

  AttendanceRepositoryImplement() : attendanceService = dI<AttendanceService>();

  @override
  Future<List<Attendance>> getAttendances(
      {required String startDate, required String endDate, required String email}) async {
    final attendances = await attendanceService
        .getAttendance(GetAttendanceRequest(startDate: startDate, endDate: endDate, email: email));
    return attendances;
  }
}
