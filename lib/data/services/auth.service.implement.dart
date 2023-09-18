import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/data/models/request/register_request.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/data/models/response/register_response.dart';
import 'package:base_app/data/services/base.service.dart';
import 'package:base_app/domain/services/auth.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl extends BaseService implements AuthService {
  late String baseUrl;

  AuthServiceImpl() : super() {
    baseUrl = appConfig.baseApiUrl;
  }
  @override
  Future<bool> forgotPassword(String username) async {
    final url = '$baseUrl${PathConfig.forgotPassword}';
    final body = jsonEncode({'username': username});
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return responseBase.result as bool;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final url = '$baseUrl${PathConfig.login}';
    final body = jsonEncode(request.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return LoginResponse.fromJson(responseBase.result);
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    final url = '$baseUrl${PathConfig.register}';
    final body = jsonEncode(request.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return RegisterResponse.fromJson(responseBase.result);
  }
}
