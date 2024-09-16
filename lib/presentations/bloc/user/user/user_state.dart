import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_state.g.dart';

@CopyWith()
@JsonSerializable()
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

  factory UserState.fromJson(Map<String, dynamic> json) => _$UserStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserStateToJson(this);
}
