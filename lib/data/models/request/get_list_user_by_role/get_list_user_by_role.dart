import 'package:json_annotation/json_annotation.dart';

part 'get_list_user_by_role.g.dart';

@JsonSerializable()
class GetListUserByRole {
  final String role;
  const GetListUserByRole({this.role = '',});

  factory GetListUserByRole.fromJson(Map<String, dynamic> json) =>
      _$GetListUserByRoleFromJson(json);
  Map<String, dynamic> toJson() => _$GetListUserByRoleToJson(this);
}
