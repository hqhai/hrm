import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance_state.g.dart';

@CopyWith()
@JsonSerializable()
class AttendanceState extends Equatable {
  final AttendanceStatus status;
  final Attendance attendance;

  const AttendanceState(
      {this.attendance = const Attendance(), this.status = AttendanceStatus.init});

  @override
  List<Object> get props => [status, attendance];

  factory AttendanceState.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStateFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceStateToJson(this);
}
