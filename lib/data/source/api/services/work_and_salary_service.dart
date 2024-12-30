import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_request.dart';
import 'package:base_app/data/models/work_and_salary/user_leave_history_response.dart';
import 'package:base_app/data/models/work_and_salary/work_shifts_response.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:injectable/injectable.dart';

import '../client/system_api_client.dart';

@LazySingleton()
class WorkAndSalaryService {
  final SystemApiClient _systemApiClient;
  final UserApiClient _userApiClient;

  WorkAndSalaryService(this._userApiClient, this._systemApiClient);

  Future<DataResponse<UserLeave>?> totalLeaveDay() async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.userLeave,
      decoder: (json) => UserLeave.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<double> totalWorkday({required StartEndResponse startEndResponse}) async {
    return 1801;
  }

  Future<DataResponse<UserLeaveHistoryResponse>?> totalLeaveUserHistory({required UserLeaveHistoryRequest userLeaveHistoryRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.userLeaveHistory,
      queryParameters: userLeaveHistoryRequest.toJson(),
      decoder: (json) => UserLeaveHistoryResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<WorkShiftsResponse>?> workShiftLeave({required StartEndResponse startEndResponse}) async {
    return _systemApiClient.request(
      method: RestMethod.get,
      path: PathConfig.workShiftByDate,
      queryParameters: startEndResponse.toJson(),
      decoder: (json) => WorkShiftsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataListResponse<WorkShiftsResponse>?> workShiftExplanation() async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.workShiftExplanation,
      decoder: (json) => WorkShiftsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataListResponse<UserLeaveHistoryTypes>?> totalLeaveType() async {
    try {
      return _userApiClient.request(
        method: RestMethod.get,
        path: PathConfig.totalLeaveType,
        decoder: (json) => UserLeaveHistoryTypes.fromJson(json as Map<String, dynamic>),
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      );
    } catch (e) {
      rethrow;
    }
  }
}
