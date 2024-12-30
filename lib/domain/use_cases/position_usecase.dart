import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/repositories/position.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class PositionUseCase {
  final PositionRepository _positionRepository;

  PositionUseCase(this._positionRepository);

  Future<int> createPosition({
    required String name,
    String? description,
  }) async {
    final response = await _positionRepository.createPosition(
      name: name,
      description: description,
    );
    return response ?? 0;
  }

  Future<List<Position>> getPositions() async {
    final response = await _positionRepository.getPositions();
    return response ?? [];
  }

  Future<Position> getPosition({required String id}) async {
    final response = await _positionRepository.getPosition(id: id);
    return response ?? const Position();
  }

  Future<int> deletePosition({required String id}) async {
    final response = await _positionRepository.deletePositions(id: id);
    return response ?? 0;
  }

  Future<int> updatePosition({
    required String id,
    required String name,
    String? description,
  }) async {
    final response = await _positionRepository.updatePosition(
      id: id,
      name: name,
      description: description,
    );
    return response ?? 0;
  }
}
