import 'package:base_app/common/enum/enum_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String fullname;
  final String id;
  final UserStatus status;

  const UserModel(
      {this.fullname = '', this.id = '', this.status = UserStatus.unknown});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
