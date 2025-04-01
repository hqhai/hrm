// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_onleave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOnLeaveRequest _$CreateOnLeaveRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOnLeaveRequest(
      type: json['type'] as String,
      isApprove: json['isApprove'] as bool,
      priority: json['priority'] as String,
      content: json['content'] as String?,
      title: json['title'] as String?,
      config: json['config'] == null
          ? const CreateOnLeaveConfigRequest()
          : CreateOnLeaveConfigRequest.fromJson(
              json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOnLeaveRequestToJson(
        CreateOnLeaveRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'isApprove': instance.isApprove,
      'priority': instance.priority,
      if (instance.title case final value?) 'title': value,
      if (instance.content case final value?) 'content': value,
      if (instance.config case final value?) 'config': value,
    };
