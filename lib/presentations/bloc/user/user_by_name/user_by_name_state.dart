import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_by_name_state.g.dart';

@CopyWith()
@JsonSerializable()
class UserByNameState extends Equatable {
  const UserByNameState({
    this.usersByName = const [],
    this.status = UserStatus.init,
    this.name = '',
    this.countItem = 0,
  });

  final List<User> usersByName;
  final String name;
  final UserStatus status;
  final int countItem;

  @override
  List<Object> get props => [usersByName, status, name, countItem];

  factory UserByNameState.fromJson(Map<String, dynamic> json) => _$UserByNameStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserByNameStateToJson(this);
}
