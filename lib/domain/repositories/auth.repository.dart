import 'package:base_app/domain/models/auth/login_response.dart';

abstract class AuthRepository {
  bool get isLoggedIn;
  Future<LoginResponse?> login(String username, String password);
  Future<bool> checkAccountBiometric(
      {required String username, required String password});
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
}
