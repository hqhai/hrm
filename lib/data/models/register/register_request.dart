import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String firstName;
  final String lastName;
  final String dayOfBirth;
  final String gender;
  final String email;
  final String password;

  const RegisterRequest(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dayOfBirth,
      required this.email,
      required this.password});

  RegisterRequest copyWith(
      {String? email,
      String? firstName,
      String? lastName,
      String? password,
      String? gender,
      String? dayOfBirth}) {
    return RegisterRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        gender: gender ?? this.gender,
        dayOfBirth: dayOfBirth ?? this.dayOfBirth);
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
