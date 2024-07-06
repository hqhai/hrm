import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response_map.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:base_app/domain/use_cases/work_and_salary.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkAndSalaryUseCase)
class WorkAndSalaryUseCaseImplement extends WorkAndSalaryUseCase {
  final WorkAndSalaryRepository _workAndSalaryRepository;

  WorkAndSalaryUseCaseImplement() : _workAndSalaryRepository = dI<WorkAndSalaryRepository>();

  @override
  Future<UserLeave> totalLeaveDay() async {
    return await _workAndSalaryRepository.totalLeaveDay();
  }

  @override
  Future<double> totalWorkday({required String startTime, required String endTime}) async {
    return await _workAndSalaryRepository.totalWorkday(startTime: startTime, endTime: endTime);
  }

  @override
  Future<UserLeaveHistoryResponseMap> totalLeaveUserHistory({DateTime? date, TypeLeaveEnum? type, int? page}) async {
    final userLeaveHistoryResponse = await _workAndSalaryRepository.totalLeaveUserHistory();
    final Map<String, UserLeaveHistory> userLeaveHistory = Map.fromEntries(
      userLeaveHistoryResponse.items.map(
        (item) => MapEntry(
          item.id,
          item,
        ),
      ),
    );
    final List<String> listIds = userLeaveHistoryResponse.items
        .map(
          (e) => e.id,
        )
        .toList();

    return UserLeaveHistoryResponseMap(
      pagingInfo: userLeaveHistoryResponse.pagingInfo,
      items: userLeaveHistory,
      listIds: listIds,
    );
  }
}
