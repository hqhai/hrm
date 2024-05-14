// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_request_by_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestByAdminRequest _$GetRequestByAdminRequestFromJson(
        Map<String, dynamic> json) =>
    GetRequestByAdminRequest(
      endDate: json['endDate'] as String,
      startDate: json['startDate'] as String,
      requestType: json['requestType'] as String,
    );

Map<String, dynamic> _$GetRequestByAdminRequestToJson(
        GetRequestByAdminRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'requestType': instance.requestType,
    };
