import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/checkin_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
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
    return const CheckInGPSResponse(checkIn: true);
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
  Future<ShiftsResponse> getWorkDays({required ShiftsRequest shiftsRequest}) async {
    final url = '$baseSystem${PathConfig.getWorkShifts}';
    final body = jsonEncode(shiftsRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final list = (data as List<dynamic>).map((e) => WorkDay.fromJson(e)).toList();
    final ShiftsResponse shiftsResponse = ShiftsResponse(items: list);
    return shiftsResponse;
  }
}
