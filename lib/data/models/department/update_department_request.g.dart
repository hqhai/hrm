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
    UpdateDepartmentRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'code': instance.code,
    'phoneNumber': instance.phoneNumber,
    'email': instance.email,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('parentId', instance.parentId);
  return val;
}
