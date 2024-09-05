import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/check_in_request.dart';
import 'package:base_app/data/models/location/datetime_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
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
      {required double longitude,
      required double latitude,
      required String scheduleSchoolId}) async {
    return _locationService.postCheckInGPS(
      checkInRequest: CheckInRequest(
        longitude: longitude,
        latitude: latitude,
        scheduleSchoolId: scheduleSchoolId,
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
  Future<ShiftsResponse> getWorkDays(
      {required DateTime startDate, required DateTime endDate}) async {
    return await _locationService.getWorkDays(
        shiftsRequest: ShiftsRequest(startTime: startDate, endTime: endDate));
  }

  @override
  Future<Shift> getShift({required String id}) async {
    return await _locationService.getShift(id: id);
  }

  @override
  Future<bool> registerWorkDays({required WorkDaysRequest request}) async {
    return await _locationService.registerWorkDays(request: request);
  }

  @override
  Future<void> cancelRegisterWorkDays(
      {required CancelWorkDayRequest request}) async {
    await _locationService.cancelRegisterWorkDays(request: request);
  }

  @override
  Future<ShiftsAdminResponse> getWorkDaysAdmin(
      {required WorkDayAdminRequest request}) async {
    return await _locationService.getWorkDaysAdmin(request: request);
  }

  @override
  Future<GetElectiveShiftResponse> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request}) async {
    return await _locationService.workDayGetElectiveShift(request: request);
  }

  @override
  Future<ShiftsAdminResponse> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request}) async {
    return await _locationService.getElectiveShiftDetail(request: request);
  }

  @override
  Future<bool> cancelWorkDay(
      {required CancelWorkDayAdminRequest request}) async {
    return await _locationService.cancelWorkDay(request: request);
  }

  @override
  Future<bool> addApprove({required ApproveRequest request}) async {
    return await _locationService.addApprove(request: request);
  }

  @override
  Future<ScheduleSchools> getScheduleSchool(
      {required DateTime workDate}) async {
    return await _locationService.getScheduleSchool(
      datetimeRequest: DatetimeRequest(workDate: workDate),
    );
  }

  @override
  Future<ShiftsAdminResponse> getWorkShiftRequestByUser() async {
    return await _locationService.getWorkShiftRequestByUser();
  }

  @override
  Future<bool> registerDetailWorkDays({required WorkDayRequest request}) async {
    return await _locationService.registerDetailWorkDays(request: request);
  }
}
