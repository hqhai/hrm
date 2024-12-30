// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInSetting _$CheckInSettingFromJson(Map<String, dynamic> json) =>
    CheckInSetting(
      morningStartTime: (json['morningStartTime'] as num).toInt(),
      morningEndTime: (json['morningEndTime'] as num).toInt(),
      afternoonStartTime: (json['afternoonStartTime'] as num).toInt(),
      afternoonEndTime: (json['afternoonEndTime'] as num).toInt(),
      departmentId: json['departmentId'] as String,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$CheckInSettingToJson(CheckInSetting instance) {
  final val = <String, dynamic>{
    'morningStartTime': instance.morningStartTime,
    'morningEndTime': instance.morningEndTime,
    'afternoonStartTime': instance.afternoonStartTime,
    'afternoonEndTime': instance.afternoonEndTime,
    'departmentId': instance.departmentId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userId', instance.userId);
  val['id'] = instance.id;
  val['createdUserId'] = instance.createdUserId;
  writeNotNull('updatedUserId', instance.updatedUserId);
  val['createdFullName'] = instance.createdFullName;
  writeNotNull('updatedFullName', instance.updatedFullName);
  val['createdDate'] = instance.createdDate;
  writeNotNull('updatedDate', instance.updatedDate);
  return val;
}
