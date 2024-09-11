import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_request.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:base_app/domain/services/work_and_salary.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkAndSalaryRepository)
class WorkAndSalaryRepositoryImplement extends WorkAndSalaryRepository {
  final WorkAndSalaryService _workAndSalaryService;

  WorkAndSalaryRepositoryImplement() : _workAndSalaryService = dI<WorkAndSalaryService>();

  @override
  Future<UserLeave> totalLeaveDay() async {
    return await _workAndSalaryService.totalLeaveDay();
  }

  @override
  Future<double> totalWorkday({required String startTime, required String endTime}) async {
    return await _workAndSalaryService.totalWorkday(
        startEndResponse: StartEndResponse(
      endDate: DateTime.parse(endTime),
      startDate: DateTime.parse(startTime),
    ));
  }

  @override
  Future<UserLeaveHistoryResponse> totalLeaveUserHistory(
      {DateTime? date, TypeLeaveEnum? type, int? page}) async {
    return await _workAndSalaryService.totalLeaveUserHistory(
      userLeaveHistoryRequest: UserLeaveHistoryRequest(
        page: page,
        type: type,
        date: date,
      ),
    );
  }

  @override
  Future<List<WorkShiftsResponse>> workShiftLeave(
      {required DateTime startTime, required DateTime endTime}) async {
    return await _workAndSalaryService.workShiftLeave(
        startEndResponse: StartEndResponse(
      endDate: endTime,
      startDate: startTime,
    ));
  }

  @override
  Future<List<WorkShiftsResponse>> workShiftExplanation() async {
    return await _workAndSalaryService.workShiftExplanation();
  }

  @override
  Future<List<UserLeaveHistoryTypes>> totalLeaveType() async {
    return await _workAndSalaryService.totalLeaveType();
  }
}
