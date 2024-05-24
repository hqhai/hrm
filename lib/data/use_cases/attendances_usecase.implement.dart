import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AttendanceUseCase)
class AttendanceUseCaseImplement extends AttendanceUseCase {
  final AttendanceRepository _attendanceRepository;

  AttendanceUseCaseImplement() : _attendanceRepository = dI<AttendanceRepository>();

  @override
  Future<List<Attendance>> getAttendances(
      {required String month, required String year, required String id}) async {
    final attendances = await _attendanceRepository.getAttendances(
        month: month, year: year, id: id);
    return attendances;
  }
}
