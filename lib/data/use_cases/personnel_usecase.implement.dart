import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/repositories/personnel.repository.dart';
import 'package:base_app/domain/use_cases/personnel_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PersonnelUseCase)
class PersonnelUseCaseImpl extends PersonnelUseCase {
  final PersonnelRepository _personnelRepository;

  PersonnelUseCaseImpl() : _personnelRepository = dI<PersonnelRepository>();

  @override
  Future<int> createPersonnel({
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
    return await _personnelRepository.createPersonnel(
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
      afternoonEndTime: afternoonEndTime
    );
  }

/*@override
  Future<List<Personnel>> getPersonnels() async {
    return await _personnelRepository.getPersonnels();
  }

  @override
  Future<Personnel> getPersonnel({required String id}) async {
    return await _personnelRepository.getPersonnel(id: id);
  }

  @override
  Future<int> deletePersonnels({required String id}) async {
    return await _personnelRepository.deletePersonnels(id: id);
  }

  @override
  Future<int> updatePersonnel(
      {required String id,
      required String name,
      required String code,
      required String phoneNumber,
      required String email,
      required String address,
      String? description,
      String? parentId}) async {
    return await _personnelRepository.updatePersonnel(
        id: id,
        name: name,
        code: code,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        description: description,
        parentId: parentId);
  }*/
}
