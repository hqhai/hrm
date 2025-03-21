// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_position_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePositionRequest _$UpdatePositionRequestFromJson(
        Map<String, dynamic> json) =>
    UpdatePositionRequest(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdatePositionRequestToJson(
        UpdatePositionRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.description case final value?) 'description': value,
    };
