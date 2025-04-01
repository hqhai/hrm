import 'package:base_app/data/models/response/login_response.dart';

abstract class AuthRepository {
  bool get isLoggedIn;
  Future<LoginResponse?> login(String username, String password);
  Future<bool> checkAccountBiometric(
      {required String username, required String password});
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);
}
