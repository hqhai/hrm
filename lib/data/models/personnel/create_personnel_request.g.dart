// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_personnel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePersonnelRequest _$CreatePersonnelRequestFromJson(
        Map<String, dynamic> json) =>
    CreatePersonnelRequest(
      code: json['code'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      startDate: json['startDate'] as String,
      attendanceId: json['attendanceId'] as String?,
      departmentId: (json['departmentId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      positionId: (json['positionId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      morningStartTime: (json['morningStartTime'] as num?)?.toInt(),
      morningEndTime: (json['morningEndTime'] as num?)?.toInt(),
      afternoonStartTime: (json['afternoonStartTime'] as num?)?.toInt(),
      afternoonEndTime: (json['afternoonEndTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreatePersonnelRequestToJson(
    CreatePersonnelRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  val['firstName'] = instance.firstName;
  val['lastName'] = instance.lastName;
  val['email'] = instance.email;
  writeNotNull('phoneNumber', instance.phoneNumber);
  val['startDate'] = instance.startDate;
  writeNotNull('attendanceId', instance.attendanceId);
  val['departmentId'] = instance.departmentId;
  val['positionId'] = instance.positionId;
  writeNotNull('morningStartTime', instance.morningStartTime);
  writeNotNull('morningEndTime', instance.morningEndTime);
  writeNotNull('afternoonStartTime', instance.afternoonStartTime);
  writeNotNull('afternoonEndTime', instance.afternoonEndTime);
  return val;
}
