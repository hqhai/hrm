// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      name: json['name'] as String,
      description: json['description'] as String?,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String?,
    );

Map<String, dynamic> _$PositionToJson(Position instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['id'] = instance.id;
  val['createdUserId'] = instance.createdUserId;
  writeNotNull('updatedUserId', instance.updatedUserId);
  val['createdFullName'] = instance.createdFullName;
  writeNotNull('updatedFullName', instance.updatedFullName);
  val['createdDate'] = instance.createdDate;
  writeNotNull('updatedDate', instance.updatedDate);
  return val;
}
