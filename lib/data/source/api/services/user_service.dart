import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/request/change_password/change_password_request.dart';
import 'package:base_app/data/models/request/get_list_user_by_role/get_list_user_by_role.dart';
import 'package:base_app/data/models/user/forgot_password_request.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_request.dart';
import 'package:base_app/data/source/api/client/auth_api_client.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import '../client/base/rest_client_base.dart';

@LazySingleton()
class UserService {
  final AuthApiClient _authApiClient;
  final UserApiClient _userApiClient;
  UserService(this._authApiClient, this._userApiClient);

  // base url

  Future<DataResponse<bool>?> changPassword(ChangePasswordRequest changePasswordRequest) async {
    return _authApiClient.request(
      method: RestMethod.post,
      path: PathConfig.changePassword,
      body: jsonEncode(changePasswordRequest.toJson()),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<String>?> forgotPassword({required ForgotPasswordRequest forgotPasswordRequest}) async {
    return _authApiClient.request(
      method: RestMethod.post,
      path: PathConfig.forgotPassword,
      body: jsonEncode(forgotPasswordRequest.toJson()),
      decoder: (json) => json as String,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<int>?> register({required RegisterRequest registerRequest}) async {
    return _authApiClient.request(
      method: RestMethod.post,
      path: PathConfig.registerSystem,
      body: jsonEncode(registerRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<int>?> deleteAccount() async {
    return _authApiClient.request(
      method: RestMethod.delete,
      path: PathConfig.deleteAccount,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  // base uer url
  Future<DataResponse<User>?> getUserInfo() async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.userInfo,
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<User>?> getUserByRole({required GetListUserByRole getListUserByRole}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.getUsersByRole,
      body: jsonEncode(getListUserByRole.toJson()),
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataResponse<User>?> updateProfile({required UpdateProfileRequest updateProfileRequest}) async {
    return _userApiClient.request(
      method: RestMethod.put,
      path: PathConfig.updateProfile,
      body: jsonEncode(updateProfileRequest.toJson()),
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  // result -> items
  Future<DataListRecordPagingResponse<User>?> getUserByFullName({required SearchUserByNameRequest searchUserByNameRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.searchUser,
      queryParameters: searchUserByNameRequest.toJson(),
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataRecordPaging,
    );
  }

  Future<DataListResponse<User>?> getUserById({required List<String> ids}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.getUserIds,
      body: jsonEncode(ids),
      decoder: (json) => User.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }
}
