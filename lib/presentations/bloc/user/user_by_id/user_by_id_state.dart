import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_by_id_state.g.dart';

@CopyWith()
@JsonSerializable()
class UserByIdState extends Equatable {
  final List<User> userById;
  final List<User> subtitudePersons;
  final UserStatus status;

  const UserByIdState({
    this.status = UserStatus.init,
    this.userById = const [],
    this.subtitudePersons = const [],
  });

  @override
  List<Object> get props => [userById, status, subtitudePersons];

  factory UserByIdState.fromJson(Map<String, dynamic> json) => _$UserByIdStateFromJson(json);

  Map<String, dynamic> toJson() => _$UserByIdStateToJson(this);
}
