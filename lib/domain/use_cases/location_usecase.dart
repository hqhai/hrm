import 'package:base_app/domain/models/location/check_in_gps_response.dart';
import 'package:base_app/domain/models/location/get_list_schools_response.dart';
import 'package:base_app/domain/models/location/get_list_schools_usecase.dart';
import 'package:base_app/domain/models/location/get_location_response.dart';
import 'package:base_app/domain/models/location/cancel_work_day_request.dart';
import 'package:base_app/domain/models/location/work_day_request.dart';
import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/models/location/shifts_response.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_schools.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/repositories/location.repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LocationUseCase {
  LocationUseCase(this._locationRepository);

  final LocationRepository _locationRepository;

  Future<GetLocationResponse> getAddress({
    required int pageSize,
    required int page,
    required String locationType,
    String? parentId,
    String? keyWord,
  }) async {
    final response = await _locationRepository.getAddress(
      pageSize: pageSize,
      page: page,
      locationType: locationType,
      parentId: parentId,
      keyWord: keyWord,
    );
    return response ?? const GetLocationResponse();
  }

  Future<CheckInGPSResponse> postCheckInGPS({
    required double longitude,
    required double latitude,
    required String scheduleSchoolId,
  }) async {
    final response = await _locationRepository.postCheckInGPS(
      longitude: longitude,
      latitude: latitude,
      scheduleSchoolId: scheduleSchoolId,
    );
    return response ?? const CheckInGPSResponse();
  }

  Future<GetListSchoolsUseCase> getListSchools({String? keyword, int page = 1}) async {
    final GetListSchoolsResponse? getListSchoolsResponse = await _locationRepository.getListSchools(keyword: keyword, page: page);
    final getListSchoolsResponseMap = getListSchoolsResponse ?? const GetListSchoolsResponse();
    final List<School> schools = getListSchoolsResponseMap.items;
    final Map<String, School> mapSchools = Map.fromEntries(
      schools.map(
        (item) => MapEntry(
          item.id,
          item,
        ),
      ),
    );
    final List<String> schoolsId = schools.map((e) => e.id).toList();
    final PagingInfoRequest pagingInfoRequest = getListSchoolsResponseMap.pagingInfo;
    final GetListSchoolsUseCase getListSchoolsUseCase = GetListSchoolsUseCase(
      schools: mapSchools,
      schoolsId: schoolsId,
      pagingInfo: pagingInfoRequest,
    );
    return getListSchoolsUseCase;
  }

  Future<ScheduleSchools> getScheduleSchool({required DateTime workDate}) async {
    final response = await _locationRepository.getScheduleSchool(workDate: workDate);
    return response ?? const ScheduleSchools();
  }

  Future<ShiftsResponse> getWorkDays({required DateTime startDate, required DateTime endDate}) async {
    final data = await _locationRepository.getWorkDays(startDate: startDate, endDate: endDate);
    return data ?? const ShiftsResponse();
  }

  Future<Shift> getShift({required String id}) async {
    final response = await _locationRepository.getShift(id: id);
    return response ?? const Shift();
  }

  Future<void> registerWorkDays({required WorkDaysRequest request}) async {
    await _locationRepository.registerWorkDays(request: request);
  }

  Future<void> cancelRegisterWorkDays({required CancelWorkDayRequest request}) async {
    await _locationRepository.cancelRegisterWorkDays(request: request);
  }

  Future<ShiftsAdminResponse> getWorkDaysAdmin({required WorkDayAdminRequest request}) async {
    final response = await _locationRepository.getWorkDaysAdmin(request: request);
    return response ?? const ShiftsAdminResponse();
  }

  Future<GetElectiveShiftResponse> workDayGetElectiveShift({required WorkDayGetElectiveShiftRequest request}) async {
    final response = await _locationRepository.workDayGetElectiveShift(request: request);
    return response ?? const GetElectiveShiftResponse();
  }

  Future<ShiftsAdminResponse> getElectiveShiftDetail({required GetElectiveShiftDetailRequest request}) async {
    final response = await _locationRepository.getElectiveShiftDetail(request: request);
    return response ?? const ShiftsAdminResponse();
  }

  Future<void> cancelWorkDay({required CancelWorkDayAdminRequest request}) async {
    await _locationRepository.cancelWorkDay(request: request);
  }

  Future<void> addApprove({required ApproveRequest request}) async {
    return await _locationRepository.addApprove(request: request);
  }

  Future<ShiftsAdminResponse> getWorkShiftRequestByUser({required WorkDayGetElectiveShiftRequest request}) async {
    final response = await _locationRepository.getWorkShiftRequestByUser(request: request);
    return response ?? const ShiftsAdminResponse();
  }

  Future<bool> registerDetailWorkDays({required WorkDayRequest request}) async {
    final response = await _locationRepository.registerDetailWorkDays(request: request);
    return response ?? false;
  }

  Future<List<Shift>> getShifts({required List<String> ids}) async {
    final response = await _locationRepository.getShifts(ids: ids);
    return response ?? [];
  }
}
