// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String?,
      updatedFullName: json['updatedFullName'] as String?,
      code: json['code'] as String?,
      canNotDelete: json['canNotDelete'] as bool?,
      fax: json['fax'] as String?,
      parentName: json['parentName'] as String?,
      childrens: (json['childrens'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdUserId': instance.createdUserId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedUserId', instance.updatedUserId);
  writeNotNull('createdFullName', instance.createdFullName);
  writeNotNull('updatedFullName', instance.updatedFullName);
  writeNotNull('code', instance.code);
  writeNotNull('name', instance.name);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('fax', instance.fax);
  writeNotNull('email', instance.email);
  writeNotNull('address', instance.address);
  writeNotNull('description', instance.description);
  writeNotNull('parentId', instance.parentId);
  writeNotNull('parentName', instance.parentName);
  writeNotNull('canNotDelete', instance.canNotDelete);
  val['childrens'] = instance.childrens;
  return val;
}
