import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response_map.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';

abstract class WorkAndSalaryUseCase {
  Future<UserLeave> totalLeaveDay();
  Future<UserLeaveHistoryResponseMap> totalLeaveUserHistory({DateTime? date, TypeLeaveEnum? type, int? page});
  Future<double> totalWorkday({required String startTime, required String endTime});
}