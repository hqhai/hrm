import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_state.g.dart';

@CopyWith()
class UserState extends Equatable {
  final User user;
  final String email;
  final UserStatus status;

  const UserState(
      {this.user = const User(id: "", createdUserId: ""), this.email = '', this.status = UserStatus.init});

  @override
  List<Object> get props => [user, email, status];
}
