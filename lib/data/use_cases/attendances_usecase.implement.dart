import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/work_and_salary/work_sheet_history_response.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:base_app/domain/use_cases/attendances_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AttendanceUseCase)
class AttendanceUseCaseImplement extends AttendanceUseCase {
  final AttendanceRepository _attendanceRepository;

  AttendanceUseCaseImplement() : _attendanceRepository = dI<AttendanceRepository>();

  @override
  Future<Attendance> workSheet({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final attendances =
        await _attendanceRepository.workSheet(endTime: endTime, startTime: startTime);
    return attendances;
  }

  @override
  Future<WorkSheet> getWorkSheet({required DateTime time}) async {
    return await _attendanceRepository.getWorkSheet(time: time);
  }

  @override
  Future<Attendance> getAttendance(
      {required String month, required String year, required String id}) async {
    final attendances = await _attendanceRepository.getAttendance(month: month, year: year, id: id);
    return attendances;
  }

  @override
  Future<WorkSheetHistoryResponse> getAttendancesByDate({required DateTime time}) async {
    final attendances = await _attendanceRepository.getAttendancesByDate(time: time);
    final map = Map.fromEntries(
      attendances.map(
        (item) => MapEntry(
          item.timeChecking.microsecondsSinceEpoch,
          item,
        ),
      ),
    );
    final keys = attendances.map((e) => e.timeChecking.microsecondsSinceEpoch).toList();
    return WorkSheetHistoryResponse(keys: keys, attendances: map);
  }
}
