// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_position_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePositionRequest _$CreatePositionRequestFromJson(
        Map<String, dynamic> json) =>
    CreatePositionRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreatePositionRequestToJson(
    CreatePositionRequest instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  return val;
}
