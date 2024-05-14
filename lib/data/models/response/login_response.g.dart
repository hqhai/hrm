// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      accessToken: json['accessToken'] as String,
      fullName: json['fullName'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isFirstLogin: json['isFirstLogin'] as bool,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'fullName': instance.fullName,
      'roles': instance.roles,
      'isFirstLogin': instance.isFirstLogin,
    };
