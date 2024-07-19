import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/checkin_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:base_app/domain/services/location.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final LocationService _locationService;

  LocationRepositoryImpl() : _locationService = dI<LocationService>();

  @override
  Future<GetLocationResponse> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId,
      String? keyWord}) async {
    return _locationService.getAddress(
        getLocationRequest: GetLocationRequest(
            pageSize: pageSize,
            page: page,
            locationType: locationType,
            parentId: parentId,
            keyWord: keyWord));
  }

  @override
  Future<CheckInGPSResponse> postCheckInGPS(
      {required double longitude, required double latitude, required DateTime time}) async {
    return _locationService.postCheckInGPS(
      checkInRequest: CheckInRequest(
        longitude: longitude,
        latitude: latitude,
        time: time,
      ),
    );
  }

  @override
  Future<GetListSchoolsResponse> getListSchools({
    String? keyword,
    int page = 1,
  }) async {
    return _locationService.getListSchools(
      keyPageRequest: KeyPageRequest(
        page: page,
        keyword: keyword,
      ),
    );
  }

  @override
  Future<ShiftsResponse> getWorkDays({required DateTime startDate, required DateTime endDate}) async {
    return await _locationService.getWorkDays(shiftsRequest: ShiftsRequest(startTime: startDate, endTime: endDate));
  }
}
