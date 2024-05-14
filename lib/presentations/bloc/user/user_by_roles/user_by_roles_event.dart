import 'package:equatable/equatable.dart';

abstract class UserByRolesEvent extends Equatable {
  const UserByRolesEvent();
}

class GetUserByRoleEvent extends UserByRolesEvent {
  final String role;

  const GetUserByRoleEvent({this.role = ''});

  @override
  List<Object> get props => [role];
}

class ResetUsersEvent extends UserByRolesEvent {
  const ResetUsersEvent();

  @override
  List<Object> get props => [];
}
