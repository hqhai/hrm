import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/check_in_request.dart';
import 'package:base_app/data/models/location/datetime_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/system_api_client.dart';
import 'package:base_app/data/source/api/client/system_gate_way_api_client.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationService {
  final SystemGateWayApiClient _systemGateWayApiClient;
  final UserApiClient _userApiClient;
  final SystemApiClient _systemApiClient;

  LocationService(
    this._systemGateWayApiClient,
    this._userApiClient,
    this._systemApiClient,
  );

  Future<DataResponse<GetLocationResponse>?> getAddress(
      {required GetLocationRequest getLocationRequest}) async {
    return _systemGateWayApiClient.request(
      method: RestMethod.get,
      path: PathConfig.location,
      queryParameters: getLocationRequest.toJson(),
      decoder: (json) =>
          GetLocationResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<bool>?> postCheckInGPS(
      {required CheckInRequest checkInRequest}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.checkIn,
      body: checkInRequest.toJson(),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<GetListSchoolsResponse>?> getListSchools(
      {required KeyPageRequest keyPageRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.schools,
      queryParameters: keyPageRequest.toJson(),
      decoder: (json) =>
          GetListSchoolsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ScheduleSchools>?> getScheduleSchool(
      {required DatetimeRequest datetimeRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.scheduleSchool,
      queryParameters: datetimeRequest.toJson(),
      decoder: (json) => ScheduleSchools.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<WorkDay>?> getWorkDays(
      {required ShiftsRequest shiftsRequest}) async {
    final request = {
      "endTime": formatYYMMDD(shiftsRequest.endTime.toString()),
      "startTime": formatYYMMDD(shiftsRequest.startTime.toString()),
    };

    return _systemApiClient.request(
      method: RestMethod.post,
      path: PathConfig.getWorkShifts,
      body: jsonEncode(request),
      decoder: (json) => WorkDay.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataResponse<Shift>?> getShift({required String id}) async {
    return _systemApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.shiftById}/$id',
      decoder: (json) => Shift.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<void>?> registerWorkDays(
      {required WorkDaysRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.post,
      path: PathConfig.registerWorkShifts,
      body: request.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<void>?> cancelRegisterWorkDays(
      {required CancelWorkDayRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.put,
      path: PathConfig.cancelRegisterWorkShifts,
      body: request.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ShiftsAdminResponse>?> getWorkDaysAdmin(
      {required WorkDayAdminRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.get,
      path: PathConfig.workShiftApprove,
      queryParameters: request.toJson(),
      decoder: (json) =>
          ShiftsAdminResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<GetElectiveShiftResponse>?> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.get,
      path: PathConfig.workshiftSettingGetElectiveShift,
      queryParameters: request.toJson(),
      decoder: (json) =>
          GetElectiveShiftResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ShiftsAdminResponse>?> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.post,
      path: PathConfig.workshiftSettingGetUser,
      queryParameters: request.toJson(),
      decoder: (json) =>
          ShiftsAdminResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<void>?> cancelWorkDay(
      {required CancelWorkDayAdminRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.put,
      path: PathConfig.workshiftRequest,
      body: request.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<void>?> addApprove(
      {required ApproveRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.put,
      path: PathConfig.workShiftApprove,
      body: request.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ShiftsAdminResponse>?> getWorkShiftRequestByUser(
      {required WorkDayGetElectiveShiftRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getWorkShiftByUser,
      queryParameters: request.toJson(),
      decoder: (json) =>
          ShiftsAdminResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<bool>?> registerDetailWorkDays(
      {required WorkDayRequest request}) async {
    return _systemApiClient.request(
      method: RestMethod.post,
      path: PathConfig.workshiftRequest,
      body: request.toJson(),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<Shift>?> getShifts(
      {required GetRequestsByIds ids}) async {
    return _systemApiClient.request(
      method: RestMethod.post,
      path: PathConfig.shiftByIds,
      body: jsonEncode(ids.toJson()),
      decoder: (json) => Shift.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }
}
