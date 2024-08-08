import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/department/create_department_request.dart';
import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/data/models/department/update_department_request.dart';
import 'package:base_app/data/models/name_page_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/repositories/department.repository.dart';
import 'package:base_app/domain/services/department.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DepartmentRepository)
class DepartmentRepositoryImpl extends DepartmentRepository {
  final DepartmentService departmentService;

  DepartmentRepositoryImpl() : departmentService = dI<DepartmentService>();

  @override
  Future<int> createDepartment(
      {required String name,
      required String code,
      required String phoneNumber,
      required String email,
      required String address,
      String? description,
      String? parentId}) async {
    int codeStatus = await departmentService.createDepartment(
        createDepartmentRequest: CreateDepartmentRequest(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            code: code,
            description: description,
            parentId: parentId));
    return codeStatus;
  }

  @override
  Future<List<Department>> getDepartments() async {
    return await departmentService.getDepartments();
  }

  @override
  Future<Department> getDepartment({required String id}) async {
    return await departmentService.getDepartment(
        id: id);
  }

  @override
  Future<int> deleteDepartments({required String id}) async {
    return await departmentService.deleteDepartment(
        deleteDepartmentRequest: ObjectByIdRequest(id: id));
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
    return await departmentService.updateDepartment(
        updateDepartmentRequest: UpdateDepartmentRequest(
            id: id,
            name: name,
            code: code,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            parentId: parentId,
            description: description));
  }

  @override
  Future<DepartmentResponse> getListDepartment({required String key, required int page}) async {
    return await departmentService.getListDepartment(
        keyPageRequest: NamePageRequest(page: page, name: key));
  }
}
