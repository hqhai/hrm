import 'package:base_app/data/models/department/create_department_request.dart';
import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/data/models/department/update_department_request.dart';
import 'package:base_app/data/models/name_page_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/source/api/services/department_service.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/repositories/department.repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DepartmentRepository)
class DepartmentRepositoryImpl extends DepartmentRepository {
  final DepartmentService _departmentService;

  DepartmentRepositoryImpl(this._departmentService);

  @override
  Future<int?> createDepartment({required String name, required String code, required String phoneNumber, required String email, required String address, String? description, String? parentId}) async {
    final response = await _departmentService.createDepartment(
      createDepartmentRequest: CreateDepartmentRequest(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        code: code,
        description: description,
        parentId: parentId,
      ),
    );
    return response?.statusCode;
  }

  @override
  Future<List<Department>?> getDepartments() async {
    final response = await _departmentService.getDepartments();
    return response?.meta?.items;
  }

  @override
  Future<Department?> getDepartment({required String id}) async {
    final response = await _departmentService.getDepartment(id: id);
    return response?.data;
  }

  @override
  Future<int?> deleteDepartments({required String id}) async {
    final response = await _departmentService.deleteDepartment(deleteDepartmentRequest: ObjectByIdRequest(id: id));
    return response?.statusCode;
  }

  @override
  Future<int?> updateDepartment({required String id, required String name, required String code, required String phoneNumber, required String email, required String address, String? description, String? parentId}) async {
    final response = await _departmentService.updateDepartment(updateDepartmentRequest: UpdateDepartmentRequest(id: id, name: name, code: code, phoneNumber: phoneNumber, email: email, address: address, parentId: parentId, description: description));
    return response?.statusCode;
  }

  @override
  Future<DepartmentResponse?> getListDepartment({required String key, required int page}) async {
    final response = await _departmentService.getListDepartment(keyPageRequest: NamePageRequest(page: page, name: key));
    return response?.data;
  }
}
