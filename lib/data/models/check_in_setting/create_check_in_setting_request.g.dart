// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_check_in_setting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCheckInSettingRequest _$CreateCheckInSettingRequestFromJson(
        Map<String, dynamic> json) =>
    CreateCheckInSettingRequest(
      morningStartTime: json['morningStartTime'] as int,
      morningEndTime: json['morningEndTime'] as int,
      afternoonStartTime: json['afternoonStartTime'] as int,
      afternoonEndTime: json['afternoonEndTime'] as int,
      departmentId: json['departmentId'] as String,
    );

Map<String, dynamic> _$CreateCheckInSettingRequestToJson(
        CreateCheckInSettingRequest instance) =>
    <String, dynamic>{
      'morningStartTime': instance.morningStartTime,
      'morningEndTime': instance.morningEndTime,
      'afternoonStartTime': instance.afternoonStartTime,
      'afternoonEndTime': instance.afternoonEndTime,
      'departmentId': instance.departmentId,
    };
