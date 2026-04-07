import 'package:base_app/domain/models/work_and_salary/work_sheet_history_response.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_list_date.dart';
import 'package:base_app/domain/repositories/attendances.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AttendanceUseCase {
  AttendanceUseCase(this._attendanceRepository);

  final AttendanceRepository _attendanceRepository;

  Future<Attendance?> workSheet({
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final attendances = await _attendanceRepository.workSheet(
        endTime: endTime, startTime: startTime);
    return attendances;
  }

  Future<WorkSheet?> getWorkSheet({required DateTime time}) async {
    return await _attendanceRepository.getWorkSheet(time: time);
  }

  Future<Attendance?> getAttendance(
      {required String month, required String year, required String id}) async {
    final attendances = await _attendanceRepository.getAttendance(
        month: month, year: year, id: id);
    return attendances;
  }

  Future<WorkSheetHistoryResponse?> getAttendancesByDate(
      {required DateTime time, required String userId}) async {
    final attendances =
        await _attendanceRepository.getAttendancesByDate(time: time, userId: userId) ?? [];
    final map = Map.fromEntries(
      attendances.map(
        (item) => MapEntry(
          item.timeChecking.microsecondsSinceEpoch,
          item,
        ),
      ),
    );
    final keys =
        attendances.map((e) => e.timeChecking.microsecondsSinceEpoch).toList();
    return WorkSheetHistoryResponse(keys: keys, attendances: map);
  }

  Future<List<AttendanceByListDate>?> getAttendanceByListDate({
    required List<String> dates,
    required String userId,
  }) async {
    final listAttendances = await _attendanceRepository.getAttendanceByListDate(
          dates: dates,
          userId: userId,
        ) ??
        [];
    return listAttendances;
  }
}
