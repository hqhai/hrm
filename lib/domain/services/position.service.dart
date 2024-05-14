
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/position/create_position_request.dart';
import 'package:base_app/data/models/position/update_position_request.dart';
import 'package:base_app/domain/entities/position.dart';

abstract class PositionService{
  Future<int> createPosition({required CreatePositionRequest createPositionRequest});

  Future<List<Position>> getPositions();

  Future<Position> getPosition(
      {required ObjectByIdRequest deletePositionRequest});

  Future<int> deletePosition({required ObjectByIdRequest deletePositionRequest});

  Future<int> updatePosition({required UpdatePositionRequest updatePositionRequest});
}