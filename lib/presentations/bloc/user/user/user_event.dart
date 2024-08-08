import 'dart:async';
import 'dart:io';

import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:equatable/equatable.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetUserInfo extends UserEvent {
  const GetUserInfo();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends UserEvent {
  final String newPassword;
  final String currentPassword;
  final Completer? completer;

  const ChangePasswordEvent({this.newPassword = '', this.currentPassword = '', this.completer});

  @override
  List<Object?> get props => [newPassword, currentPassword, completer];
}

class ResetUserEvent extends UserEvent {
  const ResetUserEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends UserEvent {
  final String email;
  final Completer? completer;

  const ForgotPasswordEvent({this.email = '', this.completer});

  @override
  List<Object?> get props => [email, completer];
}

class DeleteAccountEvent extends UserEvent {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends UserEvent {
  const UpdateProfileEvent({required this.updateProfileRequest, required this.file});
  final UpdateProfileRequest updateProfileRequest;
  final File file;

  @override
  List<Object> get props => [updateProfileRequest, file];
}
