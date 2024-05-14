// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_status_request_command_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeStatusRequestCommandModels _$ChangeStatusRequestCommandModelsFromJson(
        Map<String, dynamic> json) =>
    ChangeStatusRequestCommandModels(
      requestId: json['requestId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$ChangeStatusRequestCommandModelsToJson(
        ChangeStatusRequestCommandModels instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'status': instance.status,
      'note': instance.note,
    };
