import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/check_in_gps_response.dart';
import 'package:base_app/data/models/location/check_in_request.dart';
import 'package:base_app/data/models/location/datetime_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';

abstract class LocationService {
  Future<GetLocationResponse> getAddress({
    required GetLocationRequest getLocationRequest,
  });

  Future<CheckInGPSResponse> postCheckInGPS({
    required CheckInRequest checkInRequest,
  });

  Future<GetListSchoolsResponse> getListSchools(
      {required KeyPageRequest keyPageRequest});

  Future<ShiftsResponse> getWorkDays({required ShiftsRequest shiftsRequest});

  Future<ShiftsAdminResponse> getWorkDaysAdmin(
      {required WorkDayAdminRequest request});

  Future<void> registerWorkDays({required WorkDaysRequest request});

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

  Future<ScheduleSchool> getScheduleSchool(
      {required DatetimeRequest datetimeRequest});

  Future<ShiftsAdminResponse> getWorkShiftRequestByUser();
}
