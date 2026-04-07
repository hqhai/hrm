import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/domain/models/work_and_salary/user_leave_history_response_map.dart';
import 'package:base_app/domain/models/work_and_salary/work_shifts_map_keys.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/domain/repositories/work_and_salary.repositories.dart';
import 'package:injectable/injectable.dart';

import 'package:base_app/domain/models/work_and_salary/user_leave_history_response.dart';

@Injectable()
class WorkAndSalaryUseCase {
  WorkAndSalaryUseCase(this._workAndSalaryRepository);

  final WorkAndSalaryRepository _workAndSalaryRepository;

  Future<UserLeave> totalLeaveDay() async {
    final response = await _workAndSalaryRepository.totalLeaveDay();
    return response ?? const UserLeave();
  }

  Future<double> totalWorkday({required String startTime, required String endTime}) async {
    final response = await _workAndSalaryRepository.totalWorkday(startTime: startTime, endTime: endTime);
    return response ?? 0;
  }

  Future<UserLeaveHistoryResponseMap> totalLeaveUserHistory({DateTime? date, TypeLeaveEnum? type, int? page}) async {
    final response = await _workAndSalaryRepository.totalLeaveUserHistory(
      date: date,
      type: type,
      page: page,
    );
    final userLeaveHistoryResponse = response ?? const UserLeaveHistoryResponse();
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

  Future<WorkShiftsMapKeys> workShiftLeave({required DateTime startTime, required DateTime endTime}) async {
    final response = await _workAndSalaryRepository.workShiftLeave(
      startTime: startTime,
      endTime: endTime,
    );
    final workShiftResponse = response ?? [];
    final workShiftRegisteredDetails = workShiftResponse.expand((e) => e.workShiftRegisteredDetails).toList();
    final List<int> dates = workShiftResponse.map((e) => e.workDate?.microsecondsSinceEpoch ?? 0).toList();
    final Map<int, List<String>> mapKeyDate = Map.fromEntries(
      workShiftResponse.map(
        (item) => MapEntry(
          item.workDate?.microsecondsSinceEpoch ?? 0,
          item.workShiftRegisteredDetails.map((e) => '${e.workShiftDetailId}/${e.workShiftSettingDetailId}/${e.workDate}').toList(),
        ),
      ),
    );

    final Map<String, WorkShiftRegisteredDetail> map = Map.fromEntries(
      workShiftRegisteredDetails.map(
        (item) => MapEntry(
          '${item.workShiftDetailId}/${item.workShiftSettingDetailId}/${item.workDate}',
          item,
        ),
      ),
    );
    return WorkShiftsMapKeys(keys: dates, mapWorkShift: map, mapKeyDate: mapKeyDate);
  }

  Future<WorkShiftsMapKeys> workShiftExplanation() async {
    final response = await _workAndSalaryRepository.workShiftExplanation();
    final workShiftResponse = response ?? [];
    final workShiftRegisteredDetails = workShiftResponse.expand((e) => e.workShiftRegisteredDetails).toList();
    final List<int> dates = workShiftResponse.map((e) => e.workDate?.microsecondsSinceEpoch ?? 0).toList();
    final Map<int, List<String>> mapKeyDate = Map.fromEntries(
      workShiftResponse.map(
        (item) => MapEntry(
          item.workDate?.microsecondsSinceEpoch ?? 0,
          item.workShiftRegisteredDetails.map((e) => '${e.workShiftDetailId}/${e.workShiftSettingDetailId}').toList(),
        ),
      ),
    );

    final Map<String, WorkShiftRegisteredDetail> map = Map.fromEntries(
      workShiftRegisteredDetails.map(
        (item) => MapEntry(
          '${item.workShiftDetailId}/${item.workShiftSettingDetailId}',
          item,
        ),
      ),
    );
    return WorkShiftsMapKeys(keys: dates, mapWorkShift: map, mapKeyDate: mapKeyDate);
  }

  Future<List<UserLeaveHistoryTypes>> totalLeaveType() async {
    final response = await _workAndSalaryRepository.totalLeaveType();
    return response ?? [];
  }
}
