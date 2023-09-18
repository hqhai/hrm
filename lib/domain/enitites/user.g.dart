// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      fullname: json['fullname'] as String,
      id: json['id'] as String,
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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
