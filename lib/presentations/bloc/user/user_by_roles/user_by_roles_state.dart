import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_by_roles_state.g.dart';

@CopyWith()
class UserByRolesState extends Equatable {
  final List<User> users;
  final UserStatus status;

  const UserByRolesState({this.users = const [], this.status = UserStatus.init});

  @override
  List<Object> get props => [users, status];
}
