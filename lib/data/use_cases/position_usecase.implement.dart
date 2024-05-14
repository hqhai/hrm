import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:base_app/domain/repositories/position.repository.dart';
import 'package:base_app/domain/use_cases/position_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PositionUseCase)
class PositionUseCaseImpl extends PositionUseCase {
  final PositionRepository _positionRepository;

  PositionUseCaseImpl() : _positionRepository = dI<PositionRepository>();
  

  @override
  Future<int> createPosition(
      {required String name,
      String? description,}) async {
    return await _positionRepository.createPosition(
        name: name,
        description: description,);
  }

  @override
  Future<List<Position>> getPositions() async {
    return await _positionRepository.getPositions();
  }

  @override
  Future<Position> getPosition({required String id}) async {
    return await _positionRepository.getPosition(id: id);
  }

  @override
  Future<int> deletePosition({required String id}) async {
    return await _positionRepository.deletePositions(id: id);
  }

  @override
  Future<int> updatePosition(
      {required String id,
      required String name,
      String? description,}) async {
    return await _positionRepository.updatePosition(
        id: id,
        name: name,
        description: description,);
  }

}
