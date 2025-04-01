// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_department_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateDepartmentRequest _$UpdateDepartmentRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateDepartmentRequest(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
    );

Map<String, dynamic> _$UpdateDepartmentRequestToJson(
        UpdateDepartmentRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      if (instance.description case final value?) 'description': value,
      if (instance.parentId case final value?) 'parentId': value,
    };
