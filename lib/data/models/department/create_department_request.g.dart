// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_department_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDepartmentRequest _$CreateDepartmentRequestFromJson(
        Map<String, dynamic> json) =>
    CreateDepartmentRequest(
      name: json['name'] as String,
      code: json['code'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$CreateDepartmentRequestToJson(
        CreateDepartmentRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      if (instance.description case final value?) 'description': value,
      if (instance.parentId case final value?) 'parentId': value,
    };
