import 'package:base_app/data/models/work_and_salary/leave_day.dart';

abstract class WorkAndSalaryUseCase {
  Future<LeaveDayResponse> totalLeaveDay();
  Future<double> totalWorkday({required String startTime, required String endTime});
}