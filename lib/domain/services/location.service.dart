import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/checkin_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';

abstract class LocationService {
  Future<GetLocationResponse> getAddress({
    required GetLocationRequest getLocationRequest,
  });

  Future<CheckInGPSResponse> postCheckInGPS({
    required CheckInRequest checkInRequest,
  });
  Future<GetListSchoolsResponse> getListSchools();
}
