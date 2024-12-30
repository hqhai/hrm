import 'package:base_app/domain/repositories/personnel.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class PersonnelUseCase {
  PersonnelUseCase(this._personnelRepository);

  final PersonnelRepository _personnelRepository;

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
    final response = await _personnelRepository.createPersonnel(
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
    );
    return response ?? 0;
  }

/*@override
  Future<List<Personnel>> getPersonnels() async {
    return await _personnelRepository.getPersonnels();
  }


  Future<Personnel> getPersonnel({required String id}) async {
    return await _personnelRepository.getPersonnel(id: id);
  }


  Future<int> deletePersonnels({required String id}) async {
    return await _personnelRepository.deletePersonnels(id: id);
  }


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
