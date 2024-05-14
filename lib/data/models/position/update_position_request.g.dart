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
    UpdatePositionRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
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
