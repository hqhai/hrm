import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_response.dart';

abstract class LocationRepository {
  Future<GetLocationResponse> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId,
      String? keyWord});

  Future<CheckInGPSResponse> postCheckInGPS({
    required double longitude,
    required double latitude,
    required DateTime time,
  });

  Future<GetListSchoolsResponse> getListSchools();
}
