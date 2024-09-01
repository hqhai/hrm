import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/department/create_department_request.dart';
import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/data/models/department/update_department_request.dart';
import 'package:base_app/data/models/name_page_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/services/department.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: DepartmentService)
class DepartmentServiceImpl extends BaseService implements DepartmentService {
  late String baseUrl;
  late String baseUrlUser;

  DepartmentServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<int> createDepartment({required CreateDepartmentRequest createDepartmentRequest}) async {
    final url = '$baseUrlUser${PathConfig.department}';
    final body = jsonEncode(createDepartmentRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<List<Department>> getDepartments() async {
    final url = '$baseUrlUser${PathConfig.departments}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    List<Department> departments =
        (data as List<dynamic>).map((e) => Department.fromJson(e)).toList();
    return departments;
  }

  @override
  Future<Department> getDepartment({required String id}) async {
    final url = '$baseUrlUser${PathConfig.getDepartmentById}/$id';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Department department = Department.fromJson(data);
    return department;
  }

  @override
  Future<int> deleteDepartment({required ObjectByIdRequest deleteDepartmentRequest}) async {
    final url = '$baseUrlUser${PathConfig.department}/${deleteDepartmentRequest.id}';
    final response = await client.delete(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<int> updateDepartment({required UpdateDepartmentRequest updateDepartmentRequest}) async {
    final url = '$baseUrlUser${PathConfig.department}';
    final body = jsonEncode(updateDepartmentRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<DepartmentResponse> getListDepartment({required NamePageRequest keyPageRequest}) async {
    final url = '$baseUrlUser${PathConfig.department}';
    final params = keyPageRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final result = responseBase.result;
    final departments = DepartmentResponse.fromJson(result);
    return departments;
  }
}
