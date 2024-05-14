import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_by_admin_state.g.dart';

@CopyWith()
class UserByAdminState extends Equatable {
  final List<User> users;
  final RequestStatus status;

  const UserByAdminState({this.users = const [], this.status = RequestStatus.init,});

  @override
  List<Object> get props => [users, status];
}
