import 'package:base_app/data/models/department/create_department_request.dart';
import 'package:base_app/data/models/department/update_department_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/department.dart';

abstract class DepartmentService{
  Future<int> createDepartment({required CreateDepartmentRequest createDepartmentRequest});

  Future<List<Department>> getDepartments();

  Future<Department> getDepartment(
      {required ObjectByIdRequest deleteDepartmentRequest});

  Future<int> deleteDepartment({required ObjectByIdRequest deleteDepartmentRequest});

  Future<int> updateDepartment({required UpdateDepartmentRequest updateDepartmentRequest});
}