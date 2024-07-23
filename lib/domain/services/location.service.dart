import 'package:base_app/data/models/key_page_request.dart';
import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/checkin_request.dart';
import 'package:base_app/data/models/location/get_list_schools_response.dart';
import 'package:base_app/data/models/location/get_location_request.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/shifts/shifts_request.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';

abstract class LocationService {
  Future<GetLocationResponse> getAddress({
    required GetLocationRequest getLocationRequest,
  });

  Future<CheckInGPSResponse> postCheckInGPS({
    required CheckInRequest checkInRequest,
  });

  Future<GetListSchoolsResponse> getListSchools({required KeyPageRequest keyPageRequest});

  Future<ShiftsResponse> getWorkDays({required ShiftsRequest shiftsRequest});

  Future<Shift> getShift({required ObjectByIdRequest objectByIdRequest});
}
