import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/position/create_position_request.dart';
import 'package:base_app/data/models/position/update_position_request.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/repositories/position.repository.dart';
import 'package:base_app/domain/services/position.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PositionRepository)
class PositionRepositoryImpl extends PositionRepository {
  final PositionService positionService;

  PositionRepositoryImpl() : positionService = dI<PositionService>();

  @override
  Future<int> createPosition(
      {required String name,
      String? description,}) async {
    int codeStatus = await positionService.createPosition(
        createPositionRequest: CreatePositionRequest(
            name: name,
            description: description,));
    return codeStatus;
  }

  @override
  Future<List<Position>> getPositions() async {
    return await positionService.getPositions();
  }

  @override
  Future<Position> getPosition({required String id}) async {
    return await positionService.getPosition(
        deletePositionRequest: ObjectByIdRequest(id: id));
  }

  @override
  Future<int> deletePositions({required String id}) async {
    return await positionService.deletePosition(
        deletePositionRequest: ObjectByIdRequest(id: id));
  }

  @override
  Future<int> updatePosition(
      {required String id,
      required String name,
      String? description,}) async {
    return await positionService.updatePosition(
        updatePositionRequest: UpdatePositionRequest(
            id: id,
            name: name,
            description: description));
  }
}
