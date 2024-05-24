import 'package:json_annotation/json_annotation.dart';
part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  final String attendanceDate;
  final String? checkIn;
  final String? checkOut;
  final String? note;

  const Attendance({
    required this.attendanceDate,
    this.checkIn,
    this.checkOut,
    this.note,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
