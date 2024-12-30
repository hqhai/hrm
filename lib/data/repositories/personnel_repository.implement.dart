import 'package:base_app/data/models/personnel/create_personnel_request.dart';
import 'package:base_app/domain/repositories/personnel.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/personnel_service.dart';

@LazySingleton(as: PersonnelRepository)
class PersonnelRepositoryImpl extends PersonnelRepository {
  final PersonnelService _personnelService;

  PersonnelRepositoryImpl(this._personnelService);

  @override
  Future<int?> createPersonnel({
    String? code,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    required String startDate,
    String? attendanceId,
    required List<String> departmentId,
    required List<String> positionId,
    int? morningStartTime,
    int? morningEndTime,
    int? afternoonStartTime,
    int? afternoonEndTime,
  }) async {
    final response = await _personnelService.createPersonnel(
        createPersonnelRequest: CreatePersonnelRequest(
      code: code,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      startDate: startDate,
      attendanceId: attendanceId,
      departmentId: departmentId,
      positionId: positionId,
      morningStartTime: morningStartTime,
      morningEndTime: morningStartTime,
      afternoonStartTime: afternoonStartTime,
      afternoonEndTime: afternoonEndTime,
    ));
    return response?.statusCode;
  }
}
