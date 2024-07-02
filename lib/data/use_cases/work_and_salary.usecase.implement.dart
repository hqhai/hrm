import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/work_and_salary/leave_day.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:base_app/domain/use_cases/work_and_salary.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkAndSalaryUseCase)
class WorkAndSalaryUseCaseImplement extends WorkAndSalaryUseCase {
  final WorkAndSalaryRepository _workAndSalaryRepository;

  WorkAndSalaryUseCaseImplement() : _workAndSalaryRepository = dI<WorkAndSalaryRepository>();

  @override
  Future<LeaveDayResponse> totalLeaveDay() async {
    return await _workAndSalaryRepository.totalLeaveDay();
  }

  @override
  Future<double> totalWorkday({required String startTime, required String endTime}) async {
    return await _workAndSalaryRepository.totalWorkday(startTime: startTime, endTime: endTime);
  }
}
