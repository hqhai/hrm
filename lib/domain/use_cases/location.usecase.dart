import 'package:base_app/data/models/location/checkin_gps_response.dart';
import 'package:base_app/data/models/location/get_list_schools_usecase.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
import 'package:base_app/data/models/shifts/shifts_response.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';

abstract class LocationUseCase {
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

  Future<GetListSchoolsUseCase> getListSchools({String? keyword, int page});

  Future<ShiftsResponse> getWorkDays({required DateTime startDate, required DateTime endDate});

  Future<Shift> getShift({required String id});
}
