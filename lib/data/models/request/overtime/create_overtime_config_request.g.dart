// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_overtime_config_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOverTimeConfigRequest _$CreateOverTimeConfigRequestFromJson(
        Map<String, dynamic> json) =>
    CreateOverTimeConfigRequest(
      project: json['project'] as String? ?? '',
      task: json['task'] as String? ?? '',
      endOverTime: json['endOverTime'] as String? ?? '',
      startOverTime: json['startOverTime'] as String? ?? '',
      totalTime: json['totalTime'] as int? ?? 0,
    );

Map<String, dynamic> _$CreateOverTimeConfigRequestToJson(
        CreateOverTimeConfigRequest instance) =>
    <String, dynamic>{
      'totalTime': instance.totalTime,
      'startOverTime': instance.startOverTime,
      'endOverTime': instance.endOverTime,
      'project': instance.project,
      'task': instance.task,
    };
