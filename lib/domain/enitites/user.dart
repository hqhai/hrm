import 'package:base_app/data/models/enums/user_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String fullname;
  final String id;
  final UserStatus status;

  const User({required this.fullname, required this.id, required this.status});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
