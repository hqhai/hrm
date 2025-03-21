// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRequestRequest _$CreateRequestRequestFromJson(
        Map<String, dynamic> json) =>
    CreateRequestRequest(
      type: json['type'] as String,
      isApprove: json['isApprove'] as bool,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      priority: json['priority'] as String,
      approverId: json['approverId'] as String? ?? '',
      filePaths: (json['filePaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      config: json['config'] as String? ?? '',
    );

Map<String, dynamic> _$CreateRequestRequestToJson(
        CreateRequestRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'isApprove': instance.isApprove,
      'priority': instance.priority,
      if (instance.title case final value?) 'title': value,
      if (instance.content case final value?) 'content': value,
      if (instance.filePaths case final value?) 'filePaths': value,
      if (instance.approverId case final value?) 'approverId': value,
      if (instance.config case final value?) 'config': value,
    };
