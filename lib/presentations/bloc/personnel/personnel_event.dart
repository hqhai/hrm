import 'package:equatable/equatable.dart';

sealed class PersonnelEvent extends Equatable {
  const PersonnelEvent();

  @override
  List<Object?> get props => [];
}

class CreatePersonnelEvent extends PersonnelEvent {
  final String? code;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String startDate;
  final String? attendanceId;
  final List<String> departmentId;
  final List<String> positionId;
  final int? morningStartTime;
  final int? morningEndTime;
  final int? afternoonStartTime;
  final int? afternoonEndTime;

  const CreatePersonnelEvent({
    this.code,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.startDate,
    this.attendanceId,
    required this.departmentId,
    required this.positionId,
    this.morningStartTime,
    this.morningEndTime,
    this.afternoonStartTime,
    this.afternoonEndTime,
  });

  @override
  List<Object?> get props => [
        code,
        firstName,
        lastName,
        email,
        phoneNumber,
        startDate,
        attendanceId,
        departmentId,
        positionId,
        morningStartTime,
        morningEndTime,
        afternoonStartTime,
        afternoonEndTime
      ];
}

class GetPersonnelEvent extends PersonnelEvent {
  final String? departmentId;
  final int? page;

  const GetPersonnelEvent({this.departmentId, this.page});

  @override
  List<Object?> get props => [departmentId, page];
}
