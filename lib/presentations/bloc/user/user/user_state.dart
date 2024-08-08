import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user_state.g.dart';

@CopyWith()
class UserState extends Equatable {
  final User user;
  final String email;
  final String errorCode;
  final UserStatus status;

  const UserState(
      {this.user = const User(id: "", createdUserId: "", gender: GenderEnum.male),
      this.email = '',
      this.status = UserStatus.init,
      this.errorCode = ''});

  @override
  List<Object> get props => [user, email, status];
}
