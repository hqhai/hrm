import 'package:equatable/equatable.dart';

enum AuthStatus {
  authInitial,
  loading,
  loggedIn,
  loggedOut,
  loginFail,
  unauthentication,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String token;
  const AuthState({
    required this.status,
    this.token = '',
  });

  @override
  List<Object> get props => [status, token];
}
