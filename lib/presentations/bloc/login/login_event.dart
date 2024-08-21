part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class RequestLogin extends LoginEvent {
  final String username;
  final String password;
  final bool saveLogin;

  const RequestLogin({required this.username, required this.password, required this.saveLogin});

  @override
  List<Object> get props => [username, password, saveLogin];
}

class BiometricRequestLogin extends LoginEvent {
  final String username;
  final String password;

  const BiometricRequestLogin({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

class ValidateLogin extends LoginEvent {
  final String username;
  final String password;
  final bool check;

  const ValidateLogin({
    required this.username,
    required this.password,
    this.check = false,
  });

  @override
  List<Object> get props => [username, password, check];
}

class EmailOrUserLogin extends LoginEvent {
  final String email;

  const EmailOrUserLogin({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PassLogin extends LoginEvent {
  final String password;

  const PassLogin({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class StatusLogin extends LoginEvent {
  final int status;

  const StatusLogin({
    required this.status,
  });

  @override
  List<Object> get props => [status];
}

class ChangePasswordSuccessEvent extends LoginEvent {
  const ChangePasswordSuccessEvent();

  @override
  List<Object> get props => [];
}

class CheckBiometricAccount extends LoginEvent {
  final String username;
  final String password;
  final Completer? completer;

  const CheckBiometricAccount({
    required this.username,
    required this.password,
    this.completer,
  });

  @override
  List<Object?> get props => [username, password, completer];
}
