// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fullname: json['fullname'] as String? ?? '',
      id: json['id'] as String? ?? '',
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.unknown,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fullname': instance.fullname,
      'id': instance.id,
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
