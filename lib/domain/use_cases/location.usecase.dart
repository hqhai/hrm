import 'package:base_app/data/models/location/get_location_response.dart';

abstract class LocationUseCase {
  Future<GetLocationResponse> getAddress(
      {required int pageSize, required int page, required String locationType, String? parentId, String? keyWord});
}
