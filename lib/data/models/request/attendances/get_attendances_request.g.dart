// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendances_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceRequest _$GetAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceRequest(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$GetAttendanceRequestToJson(
        GetAttendanceRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'email': instance.email,
    };
