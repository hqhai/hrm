import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/address.dart';
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



}
