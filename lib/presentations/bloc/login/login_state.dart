import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'login_state.g.dart';

enum LoginStatus {
  initLoginState,
  loginSuccess,
  loadingState,
  loginAccountRequired,
  loginFailed,
  validateFailed,
  validateSuccess,
  statusSuccess,
  statusFalse,
  emailOrUserFalse,
  passFalse,
  errorState,
}

@CopyWith()
class LoginState extends Equatable {
  final LoginStatus status;
  final String username;
  final String pasword;
  const LoginState({
    this.status = LoginStatus.initLoginState,
    this.username = '',
    this.pasword = '',
  });

  @override
  List<Object> get props => [status, username, pasword];
}

final class LoginInitial extends LoginState {}
