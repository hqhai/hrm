import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/position/create_position_request.dart';
import 'package:base_app/data/models/position/update_position_request.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PositionService {
  final UserApiClient _userApiClient;

  PositionService(this._userApiClient);

  Future<DataResponse?> createPosition({required CreatePositionRequest createPositionRequest}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.position,
      body: jsonEncode(createPositionRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<Position>?> getPositions() async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.position,
      decoder: (json) => Position.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataResponse<Position>?> getPosition({required ObjectByIdRequest deletePositionRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.position}/${deletePositionRequest.id}',
      decoder: (json) => Position.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> deletePosition({required ObjectByIdRequest deletePositionRequest}) async {
    return _userApiClient.request(
      method: RestMethod.delete,
      path: '${PathConfig.position}/${deletePositionRequest.id}',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> updatePosition({required UpdatePositionRequest updatePositionRequest}) async {
    return _userApiClient.request(
      method: RestMethod.put,
      path: PathConfig.position,
      body: jsonEncode(updatePositionRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }
}
