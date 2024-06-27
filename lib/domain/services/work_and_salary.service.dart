import 'package:base_app/data/models/work_and_salary/leave_day.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';

abstract class WorkAndSalaryService {
  Future<LeaveDayResponse> totalLeaveDay();
  Future<double> totalWorkday({required StartEndResponse startEndResponse});
}