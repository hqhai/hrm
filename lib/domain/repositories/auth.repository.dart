import 'package:base_app/data/models/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String username, String password);
}
