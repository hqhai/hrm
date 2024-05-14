
import 'package:base_app/domain/entities/position.dart';

abstract class PositionUseCase{
  Future<int> createPosition({
    required String name,
    String? description,
  });

  Future<List<Position>> getPositions();
  Future<Position> getPosition({required String id});
  Future<int> deletePosition({required String id});

  Future<int> updatePosition({
    required String id,
    required String name,
    String? description,
  });
}