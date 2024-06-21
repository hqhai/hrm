import 'package:base_app/data/models/response/login_response.dart';
import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthenticated extends AuthEvent {
  final bool saveLogin;
  final LoginResponse? loginResponse;
  final String email;
  final String password;

  const CheckAuthenticated(
      {this.loginResponse,
      this.saveLogin = true,
      this.email = '',
      this.password = '',});

  @override
  List<Object?> get props => [loginResponse, saveLogin, email, password,];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class ResetEvent extends AuthEvent {
  const ResetEvent();
}

