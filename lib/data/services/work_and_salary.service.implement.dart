import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_request.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/services/work_and_salary.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: WorkAndSalaryService)
class WorkAndSalaryServiceImpl extends BaseService implements WorkAndSalaryService {
  late String baseUrl;
  late String baseURLFile;
  late String baseUrlUser;
  late String baseSystem;

  WorkAndSalaryServiceImpl() : super() {
    baseUrl = appConfig.baseRequestUrl;
    baseURLFile = appConfig.baseURLFile;
    baseUrlUser = appConfig.baseUserUrl;
    baseSystem = appConfig.baseSystemUrl;
  }

  @override
  Future<UserLeave> totalLeaveDay() async {
    final url = '$baseUrlUser${PathConfig.userLeave}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final UserLeave userLeave = UserLeave.fromJson(data);
    return userLeave;
  }

  @override
  Future<double> totalWorkday({required StartEndResponse startEndResponse}) async {
    return 1801;
  }

  @override
  Future<UserLeaveHistoryResponse> totalLeaveUserHistory(
      {required UserLeaveHistoryRequest userLeaveHistoryRequest}) async {
    final url = '$baseUrlUser${PathConfig.userLeaveHistory}';
    final params = userLeaveHistoryRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(
      json.decode(response.body),
    );
    final data = responseBase.result;
    final UserLeaveHistoryResponse userLeaveHistoryResponse =
        UserLeaveHistoryResponse.fromJson(data);
    return userLeaveHistoryResponse;
  }

  @override
  Future<List<WorkShiftsResponse>> workShiftLeave(
      {required StartEndResponse startEndResponse}) async {
    final url = '$baseSystem${PathConfig.workShiftByDate}';
    final params = startEndResponse.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    if (data == null) {
      return [];
    }
    final workShiftResponse =
        (data as List<dynamic>).map((e) => WorkShiftsResponse.fromJson(e)).toList();
    return workShiftResponse;
  }
}
