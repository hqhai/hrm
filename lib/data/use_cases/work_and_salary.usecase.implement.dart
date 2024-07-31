import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response_map.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_map_keys.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
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
  Future<UserLeaveHistoryResponseMap> totalLeaveUserHistory(
      {DateTime? date, TypeLeaveEnum? type, int? page}) async {
    final userLeaveHistoryResponse = await _workAndSalaryRepository.totalLeaveUserHistory(
      date: date,
      type: type,
      page: page,
    );
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

  @override
  Future<WorkShiftsMapKeys> workShiftLeave(
      {required DateTime startTime, required DateTime endTime}) async {
    final workShiftResponse = await _workAndSalaryRepository.workShiftLeave(
      startTime: startTime,
      endTime: endTime,
    );
    final workShiftRegisteredDetails =
        workShiftResponse.expand((e) => e.workShiftRegisteredDetails).toList();
    final List<int> dates = workShiftResponse.map((e) => e.workDate?.microsecondsSinceEpoch??0).toList();
    final Map<int, List<String>> mapKeyDate = Map.fromEntries(
      workShiftResponse.map(
        (item) => MapEntry(
          item.workDate?.microsecondsSinceEpoch??0,
          item.workShiftRegisteredDetails.map((e) => e.workShiftSettingDetailId).toList(),
        ),
      ),
    );

    final Map<String, WorkShiftRegisteredDetail> map = Map.fromEntries(
      workShiftRegisteredDetails.map(
        (item) => MapEntry(
          item.workShiftSettingDetailId,
          item,
        ),
      ),
    );
    return WorkShiftsMapKeys(keys: dates, mapWorkShift: map, mapKeyDate: mapKeyDate);
  }
}
