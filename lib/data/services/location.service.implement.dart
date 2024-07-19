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

  LocationServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseSystemGatewayUrl = appConfig.baseSystemGatewayUrl;
    baseUrlUser = appConfig.baseUserUrl;
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
    List<WorkDay> workDays = [
      WorkDay(
        id: '1',
        date: DateTime(2024, 07, 15),
        shifts: [
          Shift(
            id: '2024-7-15',
            endTime: DateTime(2024, 07, 15, 18, 30),
            startTime: DateTime(2024, 07, 15, 8, 30),
            dateTime: DateTime(2024, 07, 15),
          ),
        ],
      ),
      WorkDay(
        id: '2',
        date: DateTime(2024, 07, 16),
        shifts: [
          Shift(
            id: '2024-7-16',
            endTime: DateTime(2024, 07, 16, 12, 00),
            startTime: DateTime(2024, 07, 16, 8, 30),
            dateTime: DateTime(2024, 07, 16),
          ),
          Shift(
            id: '2024-7-16',
            endTime: DateTime(2024, 07, 16, 18, 30),
            startTime: DateTime(2024, 07, 16, 13, 30),
            dateTime: DateTime(2024, 07, 16),
          ),
        ],
      ),
      WorkDay(
        id: '3',
        date: DateTime(2024, 07, 17),
        shifts: [
          Shift(
            id: '2024-7-17',
            endTime: DateTime(2024, 07, 17, 12, 00),
            startTime: DateTime(2024, 07, 17, 8, 30),
            dateTime: DateTime(2024, 07, 16),
          ),
          Shift(
            id: '2024-7-17',
            endTime: DateTime(2024, 07, 17, 18, 30),
            startTime: DateTime(2024, 07, 17, 13, 30),
            dateTime: DateTime(2024, 07, 17),
          ),
          Shift(
            id: '2024-7-17',
            endTime: DateTime(2024, 07, 17, 19, 00),
            startTime: DateTime(2024, 07, 17, 21, 30),
            dateTime: DateTime(2024, 07, 17),
          ),
        ],
      ),
    ];
    return ShiftsResponse(items: workDays);
  }
}
