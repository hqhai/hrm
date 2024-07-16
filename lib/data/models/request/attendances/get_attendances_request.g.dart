// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_attendances_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAttendanceRequest _$GetAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    GetAttendanceRequest(
      startDate:
          const CustomDateTimeConverter().fromJson(json['startDate'] as String),
      endDate:
          const CustomDateTimeConverter().fromJson(json['endDate'] as String),
    );

Map<String, dynamic> _$GetAttendanceRequestToJson(
        GetAttendanceRequest instance) =>
    <String, dynamic>{
      'startDate': const CustomDateTimeConverter().toJson(instance.startDate),
      'endDate': const CustomDateTimeConverter().toJson(instance.endDate),
    };
