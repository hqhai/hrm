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
    UpdateRequestRequest instance) {
  final val = <String, dynamic>{
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
  return val;
}
