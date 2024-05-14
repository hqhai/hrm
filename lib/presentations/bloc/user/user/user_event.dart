import 'package:equatable/equatable.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends UserEvent {
  const GetUserInfo();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends UserEvent {
  final String newPassword;
  final String currentPassword;

  const ChangePasswordEvent({this.newPassword = '', this.currentPassword = ''});

  @override
  List<Object> get props => [newPassword, currentPassword];
}

class ResetUserEvent extends UserEvent {
  const ResetUserEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends UserEvent {
  final String email;

  const ForgotPasswordEvent({this.email = ''});

  @override
  List<Object> get props => [email];
}
