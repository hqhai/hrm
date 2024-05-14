import 'package:json_annotation/json_annotation.dart';
part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  final String checkDate;
  final String timeCheckIn;
  final String timeCheckOut;
  final double lateHour;
  final double timeEarly;
  final double overTime;
  final double time;
  final double work;
  final bool isEarly;
  final bool isLate;
  final String? title;
  final String? content;
  final String? noteRoomLeader;
  final String? noteManager;
  final String? requestId;

  const Attendance({
    this.checkDate = '',
    this.timeCheckIn = '',
    this.timeCheckOut = '',
    this.lateHour = 0,
    this.timeEarly = 0,
    this.overTime = 0,
    this.time = 0,
    this.work = 0,
    this.isEarly = true,
    this.isLate = true,
    this.title,
    this.content,
    this.noteRoomLeader,
    this.noteManager,
    this.requestId,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
