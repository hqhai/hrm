part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthenticated extends AuthEvent {
  final String? token;

  const CheckAuthenticated({this.token});
  @override
  List<Object?> get props => [token];
}

class Logout extends AuthEvent {
  const Logout();
}
