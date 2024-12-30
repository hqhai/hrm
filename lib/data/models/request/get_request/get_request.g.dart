// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRequestRequest _$GetRequestRequestFromJson(Map<String, dynamic> json) =>
    GetRequestRequest(
      status: json['status'] as String,
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$GetRequestRequestToJson(GetRequestRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'page': instance.page,
    };
