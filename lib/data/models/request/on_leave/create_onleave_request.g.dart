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
    CreateOnLeaveRequest instance) {
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
  writeNotNull('config', instance.config);
  return val;
}
