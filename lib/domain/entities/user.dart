import 'package:base_app/common/enum/enum_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String fullName;
  final String email;
  final String code;
  final String avatarPath;
  final String type;
  final String department;
  final String role;
  final String phoneNumber;
  final String personId;
  final UserStatus status;

  const User(
      {this.fullName = '',
      this.id = '',
      this.email = '',
      this.department = '',
      this.type = '',
      this.phoneNumber = '',
      this.avatarPath = '',
      this.code = '',
      this.personId = '',
      this.role = '',
      this.status = UserStatus.active});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
