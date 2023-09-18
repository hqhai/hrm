import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/domain/repositories/auth.repository.dart';
import 'package:base_app/domain/services/auth.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;
  AuthRepositoryImpl() : _authService = dI<AuthService>();
  @override
  Future<String> login(String username, String password) async {
    final response = await _authService
        .login(LoginRequest(password: password, username: username));
    return response.accessToken;
  }
}
