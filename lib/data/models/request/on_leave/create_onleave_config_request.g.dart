// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_onleave_config_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOnLeaveConfigRequest _$CreateOnLeaveConfigRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOnLeaveConfigRequest(
      endOnLeave: json['endOnLeave'] as String? ?? '',
      startOnLeave: json['startOnLeave'] as String? ?? '',
    );

Map<String, dynamic> _$CreateOnLeaveConfigRequestToJson(
        CreateOnLeaveConfigRequest instance) =>
    <String, dynamic>{
      'startOnLeave': instance.startOnLeave,
      'endOnLeave': instance.endOnLeave,
    };
