import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'attendance_state.g.dart';



@CopyWith()
class AttendanceState extends Equatable {
  final AttendanceStatus status;
  final List<Attendance> attendances;

  const AttendanceState({this.attendances = const [], this.status = AttendanceStatus.init});

  @override
  List<Object> get props => [attendances, status];
}
