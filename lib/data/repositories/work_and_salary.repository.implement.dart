import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/work_and_salary/leave_day.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:base_app/domain/services/work_and_salary.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkAndSalaryRepository)
class WorkAndSalaryRepositoryImplement extends WorkAndSalaryRepository {
  final WorkAndSalaryService _workAndSalaryService;

  WorkAndSalaryRepositoryImplement() : _workAndSalaryService = dI<WorkAndSalaryService>();

  @override
  Future<LeaveDayResponse> totalLeaveDay() async {
    return await _workAndSalaryService.totalLeaveDay();
  }

  @override
  Future<double> totalWorkday({required String startTime, required String endTime}) async {
    return await _workAndSalaryService.totalWorkday(
        startEndResponse: StartEndResponse(
      endTime: DateTime.parse(endTime),
      startTime:  DateTime.parse(startTime),
    ));
  }
}
