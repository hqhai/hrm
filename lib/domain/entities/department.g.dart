// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      name: json['name'] as String,
      code: json['code'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String?,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) {
  final val = <String, dynamic>{
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
  val['id'] = instance.id;
  val['createdUserId'] = instance.createdUserId;
  writeNotNull('updatedUserId', instance.updatedUserId);
  val['createdFullName'] = instance.createdFullName;
  writeNotNull('updatedFullName', instance.updatedFullName);
  val['createdDate'] = instance.createdDate;
  writeNotNull('updatedDate', instance.updatedDate);
  return val;
}
