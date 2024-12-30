// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      createdUserId: json['createdUserId'] as String? ?? '',
      updatedUserId: json['updatedUserId'] as String? ?? '',
      createdFullName: json['createdFullName'] as String? ?? '',
      updatedFullName: json['updatedFullName'] as String? ?? '',
      createdDate: json['createdDate'] as String? ?? '',
      updatedDate: json['updatedDate'] as String? ?? '',
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
      'createdUserId': instance.createdUserId,
      'updatedUserId': instance.updatedUserId,
      'createdFullName': instance.createdFullName,
      'updatedFullName': instance.updatedFullName,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
    };
