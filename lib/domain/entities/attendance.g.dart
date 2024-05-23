// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      attendanceDate: json['attendanceDate'] as String,
      checkIn: json['checkIn'] as String?,
      checkOut: json['checkOut'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) {
  final val = <String, dynamic>{
    'attendanceDate': instance.attendanceDate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('checkIn', instance.checkIn);
  writeNotNull('checkOut', instance.checkOut);
  writeNotNull('note', instance.note);
  return val;
}
