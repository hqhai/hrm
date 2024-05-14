// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      checkDate: json['checkDate'] as String? ?? '',
      timeCheckIn: json['timeCheckIn'] as String? ?? '',
      timeCheckOut: json['timeCheckOut'] as String? ?? '',
      lateHour: (json['lateHour'] as num?)?.toDouble() ?? 0,
      timeEarly: (json['timeEarly'] as num?)?.toDouble() ?? 0,
      overTime: (json['overTime'] as num?)?.toDouble() ?? 0,
      time: (json['time'] as num?)?.toDouble() ?? 0,
      work: (json['work'] as num?)?.toDouble() ?? 0,
      isEarly: json['isEarly'] as bool? ?? true,
      isLate: json['isLate'] as bool? ?? true,
      title: json['title'] as String?,
      content: json['content'] as String?,
      noteRoomLeader: json['noteRoomLeader'] as String?,
      noteManager: json['noteManager'] as String?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) {
  final val = <String, dynamic>{
    'checkDate': instance.checkDate,
    'timeCheckIn': instance.timeCheckIn,
    'timeCheckOut': instance.timeCheckOut,
    'lateHour': instance.lateHour,
    'timeEarly': instance.timeEarly,
    'overTime': instance.overTime,
    'time': instance.time,
    'work': instance.work,
    'isEarly': instance.isEarly,
    'isLate': instance.isLate,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('noteRoomLeader', instance.noteRoomLeader);
  writeNotNull('noteManager', instance.noteManager);
  writeNotNull('requestId', instance.requestId);
  return val;
}
