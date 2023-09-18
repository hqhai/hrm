import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/data/models/request/register_request.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/data/models/response/register_response.dart';

abstract class AuthService {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<bool> forgotPassword(String username);
}
