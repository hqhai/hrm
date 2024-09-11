import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_request.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';

abstract class WorkAndSalaryService {
  Future<UserLeave> totalLeaveDay();

  Future<UserLeaveHistoryResponse> totalLeaveUserHistory({
    required UserLeaveHistoryRequest userLeaveHistoryRequest,
  });

  Future<double> totalWorkday({required StartEndResponse startEndResponse});

  Future<List<WorkShiftsResponse>> workShiftLeave(
      {required StartEndResponse startEndResponse});
  Future<List<WorkShiftsResponse>> workShiftExplanation();
  Future<List<UserLeaveHistoryTypes>> totalLeaveType();
}
