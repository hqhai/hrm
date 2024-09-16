import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_list_schools_usecase.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
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
      {required double longitude,
      required double latitude,
      required String scheduleSchoolId}) async {
    return _locationRepository.postCheckInGPS(
      longitude: longitude,
      latitude: latitude,
      scheduleSchoolId: scheduleSchoolId,
    );
  }

  @override
  Future<GetListSchoolsUseCase> getListSchools(
      {String? keyword, int page = 1}) async {
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
    final PagingInfoRequest pagingInfoRequest =
        getListSchoolsResponse.pagingInfo;
    final GetListSchoolsUseCase getListSchoolsUseCase = GetListSchoolsUseCase(
        schools: mapSchools,
        schoolsId: schoolsId,
        pagingInfo: pagingInfoRequest);
    return getListSchoolsUseCase;
  }

  @override
  Future<ScheduleSchools> getScheduleSchool(
      {required DateTime workDate}) async {
    return await _locationRepository.getScheduleSchool(workDate: workDate);
  }

  @override
  Future<ShiftsResponse> getWorkDays(
      {required DateTime startDate, required DateTime endDate}) async {
    final data = await _locationRepository.getWorkDays(
        startDate: startDate, endDate: endDate);
    return data;
  }

  @override
  Future<Shift> getShift({required String id}) async {
    return await _locationRepository.getShift(id: id);
  }

  @override
  Future<void> registerWorkDays({required WorkDaysRequest request}) async {
    await _locationRepository.registerWorkDays(request: request);
  }

  @override
  Future<void> cancelRegisterWorkDays(
      {required CancelWorkDayRequest request}) async {
    await _locationRepository.cancelRegisterWorkDays(request: request);
  }

  @override
  Future<ShiftsAdminResponse> getWorkDaysAdmin(
      {required WorkDayAdminRequest request}) async {
    return await _locationRepository.getWorkDaysAdmin(request: request);
  }

  @override
  Future<GetElectiveShiftResponse> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request}) async {
    return await _locationRepository.workDayGetElectiveShift(request: request);
  }

  @override
  Future<ShiftsAdminResponse> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request}) async {
    return await _locationRepository.getElectiveShiftDetail(request: request);
  }

  @override
  Future<void> cancelWorkDay(
      {required CancelWorkDayAdminRequest request}) async {
    await _locationRepository.cancelWorkDay(request: request);
  }

  @override
  Future<bool> addApprove({required ApproveRequest request}) async {
    return await _locationRepository.addApprove(request: request);
  }

  @override
  Future<ShiftsAdminResponse> getWorkShiftRequestByUser() async {
    return await _locationRepository.getWorkShiftRequestByUser();
  }

  @override
  Future<bool> registerDetailWorkDays({required WorkDayRequest request}) async {
    return await _locationRepository.registerDetailWorkDays(request: request);
  }

  @override
  Future<List<Shift>> getShifts({required List<String> ids}) async {
    return await _locationRepository.getShifts(ids: ids);
  }
}
