import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_request.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/work_and_salary_service.dart';

@LazySingleton(as: WorkAndSalaryRepository)
class WorkAndSalaryRepositoryImplement extends WorkAndSalaryRepository {
  final WorkAndSalaryService _workAndSalaryService;

  WorkAndSalaryRepositoryImplement(this._workAndSalaryService);

  @override
  Future<UserLeave?> totalLeaveDay() async {
    final response = await _workAndSalaryService.totalLeaveDay();
    return response?.data;
  }

  @override
  Future<double?> totalWorkday({required String startTime, required String endTime}) async {
    final response = await _workAndSalaryService.totalWorkday(
        startEndResponse: StartEndResponse(
      endDate: DateTime.parse(endTime),
      startDate: DateTime.parse(startTime),
    ));
    return response;
  }

  @override
  Future<UserLeaveHistoryResponse?> totalLeaveUserHistory({DateTime? date, TypeLeaveEnum? type, int? page}) async {
    final response = await _workAndSalaryService.totalLeaveUserHistory(
      userLeaveHistoryRequest: UserLeaveHistoryRequest(
        page: page,
        type: type,
        date: date,
      ),
    );
    return response?.data;
  }

  @override
  Future<List<WorkShiftsResponse>?> workShiftLeave({required DateTime startTime, required DateTime endTime}) async {
    final response = await _workAndSalaryService.workShiftLeave(
        startEndResponse: StartEndResponse(
      endDate: endTime,
      startDate: startTime,
    ));
    return response?.result;
  }

  @override
  Future<List<WorkShiftsResponse>?> workShiftExplanation() async {
    final response = await _workAndSalaryService.workShiftExplanation();
    return response?.result;
  }

  @override
  Future<List<UserLeaveHistoryTypes>?> totalLeaveType() async {
    final response = await _workAndSalaryService.totalLeaveType();
    return response?.result;
  }
}
