import 'package:base_app/domain/entities/position.dart';

abstract class PositionRepository {
  Future<int?> createPosition({
    required String name,
    String? description,
  });

  Future<List<Position>?> getPositions();

  Future<Position?> getPosition({required String id});

  Future<int?> deletePositions({required String id});

  Future<int?> updatePosition({
    required String id,
    required String name,
    String? description,
  });
}
