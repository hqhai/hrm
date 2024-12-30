import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/repositories/department.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DepartmentUseCase {
  DepartmentUseCase(this._departmentRepository);

  final DepartmentRepository _departmentRepository;

  Future<int> createDepartment({
    required String name,
    required String code,
    required String phoneNumber,
    required String email,
    required String address,
    String? description,
    String? parentId,
  }) async {
    final response = await _departmentRepository.createDepartment(
      name: name,
      code: code,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      description: description,
      parentId: parentId,
    );
    return response ?? 0;
  }

  Future<List<Department>> getDepartments() async {
    final response = await _departmentRepository.getDepartments();
    return response ?? const [];
  }

  Future<Department> getDepartment({required String id}) async {
    final response = await _departmentRepository.getDepartment(id: id);
    return response ?? const Department();
  }

  Future<int> deleteDepartments({required String id}) async {
    final response = await _departmentRepository.deleteDepartments(id: id);
    return response ?? 0;
  }

  Future<int> updateDepartment({
    required String id,
    required String name,
    required String code,
    required String phoneNumber,
    required String email,
    required String address,
    String? description,
    String? parentId,
  }) async {
    final response = await _departmentRepository.updateDepartment(
      id: id,
      name: name,
      code: code,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
      description: description,
      parentId: parentId,
    );
    return response ?? 0;
  }

  Future<DepartmentResponse> getListDepartment({
    required String key,
    required int page,
  }) async {
    final response = await _departmentRepository.getListDepartment(
      key: key,
      page: page,
    );
    return response ?? const DepartmentResponse();
  }
}
