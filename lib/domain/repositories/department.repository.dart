import 'package:base_app/domain/entities/department.dart';

abstract class DepartmentRepository{
  Future<int> createDepartment({required String name,
    required String code,
    required String phoneNumber,
    required String email,
    required String address,
    String? description,
    String? parentId,});
  Future<List<Department>> getDepartments();
  Future<Department> getDepartment({required String id});
  Future<int> deleteDepartments({required String id});
  Future<int> updateDepartment({
    required String id,
    required String name,
    required String code,
    required String phoneNumber,
    required String email,
    required String address,
    String? description,
    String? parentId,
  });
}