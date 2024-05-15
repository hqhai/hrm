import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/request/change_password/change_password_request.dart';
import 'package:base_app/data/models/request/get_list_user_by_role/get_list_user_by_role.dart';
import 'package:base_app/data/models/user/forgot_password_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/services/user.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: UserService)
class UserServiceImpl extends BaseService implements UserService {
  late String baseUrl;
  late String baseUrlUser;

  UserServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<User> getUserInfo() async {
    final url = '$baseUrlUser${PathConfig.userInfo}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    User user = User.fromJson(responseBase.result);
    return user;
  }

  @override
  Future<bool> changPassword(ChangePasswordRequest changePasswordRequest) async {
    final url = '$baseUrl${PathConfig.changePassword}';
    final body = jsonEncode(changePasswordRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return responseBase.result as bool;
  }

  @override
  Future<List<User>> getUserByRole({required GetListUserByRole getListUserByRole}) async {
    final url = '$baseUrlUser${PathConfig.getUsersByRole}';
    final body = jsonEncode(getListUserByRole.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<User> users =
        (data as List<dynamic>).map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    return users;
  }

  @override
  Future<int> forgotPassword({required ForgotPasswordRequest forgotPasswordRequest}) async {
    final url = '$baseUrl${PathConfig.forgotPassword}';
    final body = jsonEncode(forgotPasswordRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
   return responseBase.statusCode;
  }

  @override
  Future<int> register({required RegisterRequest registerRequest}) async {
    final url = '$baseUrl${PathConfig.registerSystem}';
    final body = jsonEncode(registerRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return responseBase.statusCode;
  }

  @override
  Future<int> deleteAccount() async {
    final url = '$baseUrl${PathConfig.deleteAccount}';
    final response = await client.delete(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    int statusCode = responseBase.statusCode;
    return statusCode;
  }
}
