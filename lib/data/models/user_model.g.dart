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
  UserStatus.registered: 'registered',
  UserStatus.pending: 'pending',
  UserStatus.verified: 'verified',
  UserStatus.active: 'active',
  UserStatus.unknown: 'unknown',
};
