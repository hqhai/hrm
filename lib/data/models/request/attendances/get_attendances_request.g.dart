// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendances_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceRequest _$GetAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceRequest(
      userid: json['userid'] as String,
      year: json['year'] as String,
      month: json['month'] as String,
    );

Map<String, dynamic> _$GetAttendanceRequestToJson(
        GetAttendanceRequest instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'year': instance.year,
      'month': instance.month,
    };
