
import 'package:base_app/data/models/personnel/create_personnel_request.dart';

abstract class PersonnelService{
  Future<int> createPersonnel({required CreatePersonnelRequest createPersonnelRequest});

  /*Future<List<Personnel>> getPersonnels();

  Future<Personnel> getPersonnel(
      {required ObjectByIdRequest deletePersonnelRequest});

  Future<int> deletePersonnel({required ObjectByIdRequest deletePersonnelRequest});

  Future<int> updatePersonnel({required UpdatePersonnelRequest updatePersonnelRequest});*/
}