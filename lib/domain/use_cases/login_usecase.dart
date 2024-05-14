import 'package:base_app/data/models/response/login_response.dart';

abstract class LoginUseCase {
  Future<LoginResponse> login({required String username, required String password});
}
