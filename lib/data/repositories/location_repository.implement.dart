import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/check_in_request.dart';
import 'package:base_app/data/models/location/datetime_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/location_service.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final LocationService _locationService;

  LocationRepositoryImpl(this._locationService);

  @override
  Future<GetLocationResponse?> getAddress(
      {required int pageSize,
      required int page,
      required String locationType,
      String? parentId,
      String? keyWord}) async {
    final response = await _locationService.getAddress(
        getLocationRequest: GetLocationRequest(
            pageSize: pageSize,
            page: page,
            locationType: locationType,
            parentId: parentId,
            keyWord: keyWord));
    return response?.data;
  }

  @override
  Future<CheckInGPSResponse?> postCheckInGPS(
      {required double longitude,
      required double latitude,
      required String scheduleSchoolId}) async {
    final response = await _locationService.postCheckInGPS(
      checkInRequest: CheckInRequest(
        longitude: longitude,
        latitude: latitude,
        scheduleSchoolId: scheduleSchoolId,
      ),
    );
    return CheckInGPSResponse(checkIn: response?.data ?? false);
  }

  @override
  Future<GetListSchoolsResponse?> getListSchools({
    String? keyword,
    int page = 1,
  }) async {
    final reponse = await _locationService.getListSchools(
      keyPageRequest: KeyPageRequest(
        page: page,
        keyword: keyword,
      ),
    );
    return reponse?.data;
  }

  @override
  Future<ShiftsResponse?> getWorkDays(
      {required DateTime startDate, required DateTime endDate}) async {
    final response = await _locationService.getWorkDays(
        shiftsRequest: ShiftsRequest(startTime: startDate, endTime: endDate));
    final data = response?.result;
    final ShiftsResponse shiftsResponse = ShiftsResponse(items: data ?? []);
    return shiftsResponse;
  }

  @override
  Future<Shift?> getShift({required String id}) async {
    final reponse = await _locationService.getShift(id: id);
    return reponse?.data;
  }

  @override
  Future<void> registerWorkDays({required WorkDaysRequest request}) async {
    await _locationService.registerWorkDays(request: request);
  }

  @override
  Future<void> cancelRegisterWorkDays(
      {required CancelWorkDayRequest request}) async {
    await _locationService.cancelRegisterWorkDays(request: request);
  }

  @override
  Future<ShiftsAdminResponse?> getWorkDaysAdmin(
      {required WorkDayAdminRequest request}) async {
    final reponse = await _locationService.getWorkDaysAdmin(request: request);
    return reponse?.data;
  }

  @override
  Future<GetElectiveShiftResponse?> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request}) async {
    final reponse =
        await _locationService.workDayGetElectiveShift(request: request);
    return reponse?.data;
  }

  @override
  Future<ShiftsAdminResponse?> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request}) async {
    final reponse =
        await _locationService.getElectiveShiftDetail(request: request);
    return reponse?.data;
  }

  @override
  Future<void> cancelWorkDay(
      {required CancelWorkDayAdminRequest request}) async {
    await _locationService.cancelWorkDay(request: request);
  }

  @override
  Future<void> addApprove({required ApproveRequest request}) async {
    await _locationService.addApprove(request: request);
  }

  @override
  Future<ScheduleSchools?> getScheduleSchool(
      {required DateTime workDate}) async {
    final response = await _locationService.getScheduleSchool(
      datetimeRequest: DatetimeRequest(workDate: workDate),
    );
    return response?.data;
  }

  @override
  Future<ShiftsAdminResponse?> getWorkShiftRequestByUser(
      {required WorkDayGetElectiveShiftRequest request}) async {
    final response =
        await _locationService.getWorkShiftRequestByUser(request: request);
    return response?.data;
  }

  @override
  Future<bool?> registerDetailWorkDays(
      {required WorkDayRequest request}) async {
    final response =
        await _locationService.registerDetailWorkDays(request: request);
    return response?.data;
  }

  @override
  Future<List<Shift>?> getShifts({required List<String> ids}) async {
    final response =
        await _locationService.getShifts(ids: GetRequestsByIds(ids: ids));
    return response?.result;
  }
}
