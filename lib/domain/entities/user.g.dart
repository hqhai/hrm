// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      fullName: json['fullName'] as String? ?? '',
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      department: json['department'] as String? ?? '',
      type: json['type'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      avatarPath: json['avatarPath'] as String? ?? '',
      code: json['code'] as String? ?? '',
      personId: json['personId'] as String? ?? '',
      role: json['role'] as String? ?? '',
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.active,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'code': instance.code,
      'avatarPath': instance.avatarPath,
      'type': instance.type,
      'department': instance.department,
      'role': instance.role,
      'phoneNumber': instance.phoneNumber,
      'personId': instance.personId,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.init: 'init',
  UserStatus.getUserInfoInit: 'getUserInfoInit',
  UserStatus.getUserInfoSuccess: 'getUserInfoSuccess',
  UserStatus.getUserInfoError: 'getUserInfoError',
  UserStatus.getUserInfoErrorUnauthorized: 'getUserInfoErrorUnauthorized',
  UserStatus.getUsersByRoleInit: 'getUsersByRoleInit',
  UserStatus.getUsersByRoleSuccess: 'getUsersByRoleSuccess',
  UserStatus.getUsersByRoleError: 'getUsersByRoleError',
  UserStatus.changePasswordInit: 'changePasswordInit',
  UserStatus.changePasswordSuccess: 'changePasswordSuccess',
  UserStatus.changePasswordError: 'changePasswordError',
  UserStatus.resetPasswordInit: 'resetPasswordInit',
  UserStatus.resetPasswordSuccess: 'resetPasswordSuccess',
  UserStatus.resetPasswordError: 'resetPasswordError',
  UserStatus.forgotPasswordInit: 'forgotPasswordInit',
  UserStatus.forgotPasswordSuccess: 'forgotPasswordSuccess',
  UserStatus.forgotPasswordError: 'forgotPasswordError',
  UserStatus.registered: 'registered',
  UserStatus.pending: 'pending',
  UserStatus.verified: 'verified',
  UserStatus.active: 'active',
  UserStatus.unknown: 'unknown',
  UserStatus.deleteAccountInit: 'deleteAccountInit',
  UserStatus.deleteAccountSuccess: 'deleteAccountSuccess',
  UserStatus.deleteAccountError: 'deleteAccountError',
};
