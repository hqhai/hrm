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
    CreateRequestRequest instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'isApprove': instance.isApprove,
    'priority': instance.priority,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('filePaths', instance.filePaths);
  writeNotNull('approverId', instance.approverId);
  writeNotNull('config', instance.config);
  return val;
}
