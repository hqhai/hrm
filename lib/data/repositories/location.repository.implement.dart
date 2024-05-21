import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:base_app/domain/services/location.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final LocationService locationService;

  LocationRepositoryImpl() : locationService = dI<LocationService>();

  @override
  Future<List<Address>> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId}) async {
    return locationService.getAddress(
        getLocationRequest: GetLocationRequest(
            pageSize: pageSize, page: page, locationType: locationType, parentId: parentId));
  }
}
