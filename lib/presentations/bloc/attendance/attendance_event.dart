import 'package:equatable/equatable.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetAttendanceEvent extends AttendanceEvent {
  final int year;
  final int month;
  final String id;

  const GetAttendanceEvent({this.id = '', this.year = 0, this.month = 0});

  @override
  List<Object> get props => [id, year, month];
}


class GetWorkSheetEvent extends AttendanceEvent {
  final DateTime startTime;
  final DateTime endTime;

  const GetWorkSheetEvent({required this.startTime, required this.endTime});

  @override
  List<Object> get props => [startTime, endTime];
}

class GetAttendanceNowEvent extends AttendanceEvent {
  final String id;
  const GetAttendanceNowEvent({this.id = ''});

  @override
  List<Object> get props => [id];
}

class ResetAttendanceEvent extends AttendanceEvent {
  const ResetAttendanceEvent();

  @override
  List<Object> get props => [];
}
