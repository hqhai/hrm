

abstract class PersonnelUseCase{
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
  });

  /*Future<List<Personnel>> getPersonnels();
  Future<Personnel> getPersonnel({required String id});
  Future<int> deletePersonnels({required String id});*/

  /*Future<int> updatePersonnel({
    required String id,
    required String name,
    required String code,
    required String phoneNumber,
    required String email,
    required String address,
    String? description,
    String? parentId,
  });*/
}