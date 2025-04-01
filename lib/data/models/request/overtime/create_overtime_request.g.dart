// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_overtime_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOverTimeRequest _$CreateOverTimeRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOverTimeRequest(
      type: json['type'] as String,
      isApprove: json['isApprove'] as bool,
      config: json['config'] == null
          ? const ListRequestTypes()
          : ListRequestTypes.fromJson(json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOverTimeRequestToJson(
        CreateOverTimeRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'isApprove': instance.isApprove,
      if (instance.config case final value?) 'config': value,
    };
