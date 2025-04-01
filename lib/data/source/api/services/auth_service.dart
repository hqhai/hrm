import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/storage/local_storage.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/data/source/api/client/auth_api_client.dart';
import 'package:injectable/injectable.dart';

import '../../../models/base/data_response.dart';
import '../client/base/rest_client_base.dart';
import '../mapper/base_success_response_mapper.dart';

@LazySingleton()
class AuthService {
  AuthService(this._authApiClient);

  final AuthApiClient _authApiClient;

  Future<DataResponse<LoginResponse>?> login(LoginRequest request) async {
    return await _authApiClient.request(
      method: RestMethod.post,
      path: PathConfig.login,
      body: jsonEncode(request.toJson()),
      decoder: (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<bool> checkAccountBiometric({required LoginRequest request}) async {
    final passwordBiometric =
        await AppLocalStorage.getData(DataKey.passwordBiometric);
    final password = request.password;
    if (passwordBiometric == null) return false;
    if (passwordBiometric.contains(password)) {
      return true;
    } else {
      return false;
    }
  }
}
