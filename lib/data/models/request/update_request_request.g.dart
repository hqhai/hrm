// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_request_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateRequestRequest _$UpdateRequestRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateRequestRequest(
      priority: json['priority'] as String,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      filePaths: (json['filePaths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UpdateRequestRequestToJson(
        UpdateRequestRequest instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      if (instance.title case final value?) 'title': value,
      if (instance.content case final value?) 'content': value,
      if (instance.filePaths case final value?) 'filePaths': value,
    };
