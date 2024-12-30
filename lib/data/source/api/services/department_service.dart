import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/department/create_department_request.dart';
import 'package:base_app/data/models/department/department_response.dart';
import 'package:base_app/data/models/department/update_department_request.dart';
import 'package:base_app/data/models/name_page_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:injectable/injectable.dart';

import '../../../models/base/data_response.dart';

@LazySingleton()
class DepartmentService {
  final UserApiClient _userApiClient;

  DepartmentService(this._userApiClient) : super();

  Future<DataResponse?> createDepartment(
      {required CreateDepartmentRequest createDepartmentRequest}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.department,
      body: jsonEncode(createDepartmentRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  // result-> items
  Future<DataListRecordPagingResponse<Department>?> getDepartments() async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.departments,
      decoder: (json) => Department.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataRecordPaging,
    );
  }

  Future<DataResponse<Department>?> getDepartment({required String id}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.getDepartmentById}/$id',
      decoder: (json) => Department.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> deleteDepartment(
      {required ObjectByIdRequest deleteDepartmentRequest}) async {
    return _userApiClient.request(
      method: RestMethod.delete,
      path: '${PathConfig.department}/${deleteDepartmentRequest.id}',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> updateDepartment(
      {required UpdateDepartmentRequest updateDepartmentRequest}) async {
    return _userApiClient.request(
      method: RestMethod.put,
      path: PathConfig.department,
      body: jsonEncode(updateDepartmentRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<DepartmentResponse>?> getListDepartment(
      {required NamePageRequest keyPageRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.department,
      queryParameters: keyPageRequest.toJson(),
      decoder: (json) =>
          DepartmentResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }
}
