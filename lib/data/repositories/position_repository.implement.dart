import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/position/create_position_request.dart';
import 'package:base_app/data/models/position/update_position_request.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/repositories/position.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/position_service.dart';

@LazySingleton(as: PositionRepository)
class PositionRepositoryImpl extends PositionRepository {
  final PositionService _positionService;

  PositionRepositoryImpl(this._positionService);

  @override
  Future<int?> createPosition({
    required String name,
    String? description,
  }) async {
    final response = await _positionService.createPosition(
        createPositionRequest: CreatePositionRequest(
      name: name,
      description: description,
    ));
    return response?.statusCode;
  }

  @override
  Future<List<Position>?> getPositions() async {
    final response = await _positionService.getPositions();
    return response?.result;
  }

  @override
  Future<Position?> getPosition({required String id}) async {
    final response = await _positionService.getPosition(deletePositionRequest: ObjectByIdRequest(id: id));
    return response?.data;
  }

  @override
  Future<int?> deletePositions({required String id}) async {
    final response = await _positionService.deletePosition(deletePositionRequest: ObjectByIdRequest(id: id));
    return response?.statusCode;
  }

  @override
  Future<int?> updatePosition({
    required String id,
    required String name,
    String? description,
  }) async {
    final response = await _positionService.updatePosition(updatePositionRequest: UpdatePositionRequest(id: id, name: name, description: description));
    return response?.statusCode;
  }
}
