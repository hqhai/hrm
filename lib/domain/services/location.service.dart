import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';

abstract class LocationService {
  Future<GetLocationResponse> getAddress({
    required GetLocationRequest getLocationRequest,
  });
}
