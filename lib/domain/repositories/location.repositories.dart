import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';

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
    required String scheduleSchoolId,
  });

  Future<ScheduleSchools> getScheduleSchool({required DateTime workDate});

  Future<GetListSchoolsResponse> getListSchools({String? keyword, int page});

  Future<ShiftsAdminResponse> getWorkDaysAdmin(
      {required WorkDayAdminRequest request});

  Future<ShiftsResponse> getWorkDays(
      {required DateTime startDate, required DateTime endDate});

  Future<bool> registerWorkDays({required WorkDaysRequest request});
  Future<void> cancelRegisterWorkDays({required CancelWorkDayRequest request});

  Future<GetElectiveShiftResponse> workDayGetElectiveShift(
      {required WorkDayGetElectiveShiftRequest request});

  Future<Shift> getShift({required String id});

  Future<ShiftsAdminResponse> getElectiveShiftDetail(
      {required GetElectiveShiftDetailRequest request});

  Future<bool> cancelWorkDay({
    required CancelWorkDayAdminRequest request,
  });

  Future<bool> addApprove({required ApproveRequest request});

  Future<ShiftsAdminResponse> getWorkShiftRequestByUser();

  Future<bool> registerDetailWorkDays({required WorkDayRequest request});
}
