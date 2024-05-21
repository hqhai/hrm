import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationUseCase)
class LocationUseCaseImpl extends LocationUseCase {
  final LocationRepository _locationRepository;

  LocationUseCaseImpl() : _locationRepository = dI<LocationRepository>();

  @override
  Future<List<Address>> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId}) async {
    return _locationRepository.getAddress(
        pageSize: pageSize, page: page, locationType: locationType, parentId: parentId);
  }
}
