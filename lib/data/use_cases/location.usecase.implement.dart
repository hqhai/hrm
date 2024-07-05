import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_list_schools_usecase.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationUseCase)
class LocationUseCaseImpl extends LocationUseCase {
  final LocationRepository _locationRepository;

  LocationUseCaseImpl() : _locationRepository = dI<LocationRepository>();

  @override
  Future<GetLocationResponse> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId,
      String? keyWord}) async {
    return _locationRepository.getAddress(
        pageSize: pageSize,
        page: page,
        locationType: locationType,
        parentId: parentId,
        keyWord: keyWord);
  }

  @override
  Future<CheckInGPSResponse> postCheckInGPS(
      {required double longitude, required double latitude, required DateTime time}) async {
    return _locationRepository.postCheckInGPS(
      longitude: longitude,
      latitude: latitude,
      time: time,
    );
  }

  @override
  Future<GetListSchoolsUseCase> getListSchools({String? keyword, int page = 1}) async {
    final GetListSchoolsResponse getListSchoolsResponse =
        await _locationRepository.getListSchools(keyword: keyword, page: page);
    final List<School> schools = getListSchoolsResponse.items;
    final Map<String, School> mapSchools = Map.fromEntries(
      schools.map(
        (item) => MapEntry(
          item.id,
          item,
        ),
      ),
    );
    final List<String> schoolsId = schools.map((e) => e.id).toList();
    final PagingInfoRequest pagingInfoRequest = getListSchoolsResponse.pagingInfo;
    final GetListSchoolsUseCase getListSchoolsUseCase = GetListSchoolsUseCase(
      schools: mapSchools,
      schoolsId: schoolsId,
      pagingInfo: pagingInfoRequest
    );
    return getListSchoolsUseCase;
  }
}
