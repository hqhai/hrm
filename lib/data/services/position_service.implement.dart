import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/position/create_position_request.dart';
import 'package:base_app/data/models/position/update_position_request.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/services/position.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: PositionService)
class PositionServiceImpl extends BaseService implements PositionService {
  late String baseUrl;
  late String baseUrlUser;

  PositionServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<int> createPosition({required CreatePositionRequest createPositionRequest}) async {
    final url = '$baseUrlUser${PathConfig.position}';
    final body = jsonEncode(createPositionRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<List<Position>> getPositions() async {
    final url = '$baseUrlUser${PathConfig.position}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<Position> departments =
        (data as List<dynamic>).map((e) => Position.fromJson(e as Map<String, dynamic>)).toList();
    return departments;
  }

  @override
  Future<Position> getPosition(
      {required ObjectByIdRequest deletePositionRequest}) async {
    final url = '$baseUrlUser${PathConfig.position}/${deletePositionRequest.id}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Position department = Position.fromJson(data);
    return department;
  }

  @override
  Future<int> deletePosition({required ObjectByIdRequest deletePositionRequest}) async {
    final url = '$baseUrlUser${PathConfig.position}/${deletePositionRequest.id}';
    final response = await client.delete(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<int> updatePosition({required UpdatePositionRequest updatePositionRequest}) async {
    final url = '$baseUrlUser${PathConfig.position}';
    final body = jsonEncode(updatePositionRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }
}
