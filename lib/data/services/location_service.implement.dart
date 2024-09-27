import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/check_in_request.dart';
import 'package:base_app/data/models/location/datetime_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/domain/services/location.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl extends BaseService implements LocationService {
  late String baseUrl;
  late String baseSystemGatewayUrl;
  late String baseUrlUser;
  late String baseSystem;

  LocationServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseSystemGatewayUrl = appConfig.baseSystemGatewayUrl;
    baseUrlUser = appConfig.baseUserUrl;
    baseSystem = appConfig.baseSystemUrl;
  }

  @override
  Future<GetLocationResponse> getAddress({required GetLocationRequest getLocationRequest}) async {
    final url = '$baseSystemGatewayUrl${PathConfig.location}';
    final params = getLocationRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    GetLocationResponse addresses = GetLocationResponse.fromJson(data);
    return addresses;
  }

  @override
  Future<CheckInGPSResponse> postCheckInGPS({required CheckInRequest checkInRequest}) async {
    final url = '$baseUrlUser${PathConfig.checkIn}';
    final body = jsonEncode(checkInRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final result = responseBase.result;
    final checkInGPSResponse = CheckInGPSResponse(checkIn: result);
    return checkInGPSResponse;
  }

  @override
  Future<GetListSchoolsResponse> getListSchools({required KeyPageRequest keyPageRequest}) async {
    final url = '$baseUrlUser${PathConfig.schools}';
    final params = keyPageRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final GetListSchoolsResponse getListSchoolsResponse = GetListSchoolsResponse.fromJson(data);
    return getListSchoolsResponse;
  }

  @override
  Future<ScheduleSchools> getScheduleSchool({required DatetimeRequest datetimeRequest}) async {
    final url = '$baseUrlUser${PathConfig.scheduleSchool}';
    final params = datetimeRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final scheduleSchool = ScheduleSchools.fromJson(data);
    return scheduleSchool;
  }

  @override
  Future<ShiftsResponse> getWorkDays({required ShiftsRequest shiftsRequest}) async {
    final url = '$baseSystem${PathConfig.getWorkShifts}';
    final request = {
      "endTime": formatYYMMDD(shiftsRequest.endTime.toString()),
      "startTime": formatYYMMDD(shiftsRequest.startTime.toString())
    };
    final body = jsonEncode(request);
    final response = await client.post(url, body: body, customHeaders: {});
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final list = (data as List<dynamic>).map((e) => WorkDay.fromJson(e)).toList();
    final ShiftsResponse shiftsResponse = ShiftsResponse(items: list);
    return shiftsResponse;
  }

  @override
  Future<Shift> getShift({required String id}) async {
    final url = '$baseSystem${PathConfig.shiftById}/$id';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final shift = Shift.fromJson(data);
    return shift;
  }

  @override
  Future<void> registerWorkDays({required WorkDaysRequest request}) async {
    final url = '$baseSystem${PathConfig.registerWorkShifts}';
    final body = jsonEncode(request.toJson());
    await client.post(url, body: body);
  }

  @override
  Future<void> cancelRegisterWorkDays({required CancelWorkDayRequest request}) async {
    final url = '$baseSystem${PathConfig.cancelRegisterWorkShifts}';
    final body = jsonEncode(request.toJson());
    await client.put(url, body: body);
  }

  @override
  Future<ShiftsAdminResponse> getWorkDaysAdmin({required WorkDayAdminRequest request}) async {
    final url = '$baseSystem${PathConfig.workShiftApprove}';
    final params = request.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));

    return ShiftsAdminResponse.fromJson(responseBase.result);
  }

  @override
  Future<GetElectiveShiftResponse> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request}) async {
    final url = '$baseSystem${PathConfig.workshiftSettingGetElectiveShift}';
    final params = request.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return GetElectiveShiftResponse.fromJson(responseBase.result);
  }

  @override
  Future<ShiftsAdminResponse> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request}) async {
    final url = '$baseSystem${PathConfig.workshiftSettingGetUser}';
    final params = request.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return ShiftsAdminResponse.fromJson(responseBase.result);
  }

  @override
  Future<void> cancelWorkDay({required CancelWorkDayAdminRequest request}) async {
      final url = '$baseSystem${PathConfig.workshiftRequest}';
      final body = jsonEncode(request.toJson());
      await client.put(url, body: body);
  }

  @override
  Future<void> addApprove({required ApproveRequest request}) async {
      final url = '$baseSystem${PathConfig.workShiftApprove}';
      final body = jsonEncode(request.toJson());
      await client.put(url, body: body);
  }

  @override
  Future<ShiftsAdminResponse> getWorkShiftRequestByUser() async {
    final url = '$baseSystem${PathConfig.getWorkShiftByUser}?page=1&pageSize=10000';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return ShiftsAdminResponse.fromJson(responseBase.result);
  }

  @override
  Future<bool> registerDetailWorkDays({required WorkDayRequest request}) async {
    try {
      final url = '$baseSystem${PathConfig.workshiftRequest}';
      final body = jsonEncode(request.toJson());
      await client.post(url, body: body);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Shift>> getShifts({required GetRequestsByIds ids}) async {
    final url = '$baseSystem${PathConfig.shiftByIds}';
    final body = jsonEncode(ids.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final shifts = (data as List<dynamic>)
        .map((e) => Shift.fromJson(e as Map<String, dynamic>))
        .toList();
    return shifts;
  }
}
