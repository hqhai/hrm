import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/domain/repositories/auth.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/auth_service.dart';
import '../source/preference/preference.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;
  final AppPreferences _appPreferences;

  AuthRepositoryImpl(this._authService, this._appPreferences);

  @override
  Future<LoginResponse?> login(String username, String password) async {
    final response = await _authService
        .login(LoginRequest(password: password, username: username));

    if (response?.data?.accessToken != null) {
      saveAccessToken(response?.data?.accessToken ?? "");
    }
    if (response?.data?.refreshToken != null) {
      saveRefreshToken(response?.data?.refreshToken ?? "");
    }
    return response?.data;
  }

  @override
  bool get isLoggedIn => _appPreferences.isLoggedIn;

  @override
  Future<void> saveAccessToken(String accessToken) =>
      _appPreferences.saveAccessToken(accessToken);

  @override
  Future<void> saveRefreshToken(String refreshToken) =>
      _appPreferences.saveRefreshToken(refreshToken);

  @override
  Future<bool> checkAccountBiometric(
      {required String username, required String password}) async {
    return await _authService.checkAccountBiometric(
        request: LoginRequest(password: password, username: username));
  }
}
