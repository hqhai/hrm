import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';

abstract class WorkAndSalaryRepository {
  Future<UserLeave> totalLeaveDay();

  Future<UserLeaveHistoryResponse> totalLeaveUserHistory({
    DateTime? date,
    TypeLeaveEnum? type,
    int? page,
  });

  Future<double> totalWorkday({required String startTime, required String endTime});

  Future<List<WorkShiftsResponse>> workShiftLeave(
      {required DateTime startTime, required DateTime endTime});

  Future<List<WorkShiftsResponse>> workShiftExplanation();
  Future<List<UserLeaveHistoryTypes>> totalLeaveType();
}
