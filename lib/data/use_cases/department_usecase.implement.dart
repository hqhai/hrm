import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/repositories/department.repository.dart';
import 'package:base_app/domain/use_cases/departments_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DepartmentUseCase)
class DepartmentUseCaseImpl extends DepartmentUseCase {
  final DepartmentRepository _departmentRepository;

  DepartmentUseCaseImpl() : _departmentRepository = dI<DepartmentRepository>();
  

  @override
  Future<int> createDepartment(
      {required String name,
      required String code,
      required String phoneNumber,
      required String email,
      required String address,
      String? description,
      String? parentId}) async {
    return await _departmentRepository.createDepartment(
        name: name,
        code: code,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        description: description,
        parentId: parentId);
  }

  @override
  Future<List<Department>> getDepartments() async {
    return await _departmentRepository.getDepartments();
  }

  @override
  Future<Department> getDepartment({required String id}) async {
    return await _departmentRepository.getDepartment(id: id);
  }

  @override
  Future<int> deleteDepartments({required String id}) async {
    return await _departmentRepository.deleteDepartments(id: id);
  }

  @override
  Future<int> updateDepartment(
      {required String id,
      required String name,
      required String code,
      required String phoneNumber,
      required String email,
      required String address,
      String? description,
      String? parentId}) async {
    return await _departmentRepository.updateDepartment(
        id: id,
        name: name,
        code: code,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        description: description,
        parentId: parentId);
  }

  @override
  Future<DepartmentResponse> getListDepartment({required String key, required int page}) async {
    return await _departmentRepository.getListDepartment(key: key, page: page);
  }

}
