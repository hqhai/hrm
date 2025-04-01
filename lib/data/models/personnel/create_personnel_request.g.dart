// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_personnel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePersonnelRequest _$CreatePersonnelRequestFromJson(
        Map<String, dynamic> json) =>
    CreatePersonnelRequest(
      code: json['code'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      startDate: json['startDate'] as String,
      attendanceId: json['attendanceId'] as String?,
      departmentId: (json['departmentId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      positionId: (json['positionId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      morningStartTime: (json['morningStartTime'] as num?)?.toInt(),
      morningEndTime: (json['morningEndTime'] as num?)?.toInt(),
      afternoonStartTime: (json['afternoonStartTime'] as num?)?.toInt(),
      afternoonEndTime: (json['afternoonEndTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreatePersonnelRequestToJson(
        CreatePersonnelRequest instance) =>
    <String, dynamic>{
      if (instance.code case final value?) 'code': value,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      if (instance.phoneNumber case final value?) 'phoneNumber': value,
      'startDate': instance.startDate,
      if (instance.attendanceId case final value?) 'attendanceId': value,
      'departmentId': instance.departmentId,
      'positionId': instance.positionId,
      if (instance.morningStartTime case final value?)
        'morningStartTime': value,
      if (instance.morningEndTime case final value?) 'morningEndTime': value,
      if (instance.afternoonStartTime case final value?)
        'afternoonStartTime': value,
      if (instance.afternoonEndTime case final value?)
        'afternoonEndTime': value,
    };
