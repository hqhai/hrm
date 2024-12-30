// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String? ?? '',
      address: json['address'] as String? ?? '',
      description: json['description'] as String? ?? '',
      parentId: json['parentId'] as String? ?? '',
      id: json['id'] as String? ?? '',
      createdUserId: json['createdUserId'] as String? ?? '',
      updatedUserId: json['updatedUserId'] as String? ?? '',
      createdFullName: json['createdFullName'] as String? ?? '',
      updatedFullName: json['updatedFullName'] as String? ?? '',
      code: json['code'] as String? ?? '',
      canNotDelete: json['canNotDelete'] as bool? ?? false,
      fax: json['fax'] as String? ?? '',
      parentName: json['parentName'] as String? ?? '',
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdUserId': instance.createdUserId,
      'updatedUserId': instance.updatedUserId,
      'createdFullName': instance.createdFullName,
      'updatedFullName': instance.updatedFullName,
      'code': instance.code,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'fax': instance.fax,
      'email': instance.email,
      'address': instance.address,
      'description': instance.description,
      'parentId': instance.parentId,
      'parentName': instance.parentName,
      'canNotDelete': instance.canNotDelete,
      'children': instance.children,
    };
