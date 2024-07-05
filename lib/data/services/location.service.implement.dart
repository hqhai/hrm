import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/checkin_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/services/location.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl extends BaseService implements LocationService {
  late String baseUrl;
  late String baseSystemGatewayUrl;

  LocationServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseSystemGatewayUrl = appConfig.baseSystemGatewayUrl;
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
  Future<GetListSchoolsResponse> getListSchools() async {
    final List<School> schools = [
      const School(
        id: '1',
        longitude: 100,
        latitude: 100,
        addressSchool: 'Không biết',
        nameSchool: 'Trường đời',
      ),
      const School(
        id: '2',
        latitude: 37.423767,
        longitude: -122.090023,
        addressSchool: 'Trụ sở google',
        nameSchool: 'Trường vip',
      ),
      const School(
          id: '3',
          latitude: 21.007588,
          longitude: 105.874341,
          addressSchool: 'Sông hồng',
          nameSchool: 'Trường dưới sông,'),
    ];
    final GetListSchoolsResponse getListSchoolsResponse = GetListSchoolsResponse(
      items: schools,
    );
    return getListSchoolsResponse;
  }
}
