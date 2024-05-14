import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String fullName;
  final List<String> roles;
  final bool isFirstLogin;

  const LoginResponse(
      {required this.accessToken,
      required this.fullName,
      required this.roles,
      required this.isFirstLogin});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
