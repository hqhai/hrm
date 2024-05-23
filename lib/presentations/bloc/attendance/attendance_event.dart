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
