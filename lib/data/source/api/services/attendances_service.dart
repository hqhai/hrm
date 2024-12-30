import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/request/attendances/get_attendance_request.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/data/models/work_and_salary/work_sheet_history_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:injectable/injectable.dart';

import '../../../models/base/data_response.dart';
import '../client/base/rest_client_base.dart';
import '../client/user_api_client.dart';
import '../mapper/base_success_response_mapper.dart';

@LazySingleton()
class AttendanceService {
  AttendanceService(this._apiClient) : super();

  final UserApiClient _apiClient;

  Future<DataResponse<Attendance>?> getAttendance(GetAttendancesRequest getAttendanceRequest) async {
    return _apiClient.request(
      method: RestMethod.get,
      path: PathConfig.worksheet,
      queryParameters: getAttendanceRequest.toJson(),
      decoder: (json) => Attendance.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<WorkSheet> getWorkSheet({required GetWorkSheetRequest time}) async {
    return const WorkSheet(
      actualWork: 1,
      holidayWork: 2,
      leaveWork: 3,
      noSalaryWork: 4,
      overTime: 5,
      realWork: 6,
      salaryWork: 7,
      timeEarly: 8,
      timeLate: 9,
      workTime: 10,
    );
  }

  Future<DataResponse<Attendance>?> workSheet(GetAttendanceRequest getAttendanceRequest) async {
    return _apiClient.request(
      method: RestMethod.get,
      path: PathConfig.worksheet,
      queryParameters: getAttendanceRequest.toJson(),
      decoder: (json) => Attendance.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<AttendanceByDate>?> getAttendancesByDate({required WorkSheetHistoryRequest workSheetHistoryRequest}) async {
    return _apiClient.request(
      method: RestMethod.get,
      path: PathConfig.attendanceByDate,
      queryParameters: workSheetHistoryRequest.toJson(),
      decoder: (json) => AttendanceByDate.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }
}
