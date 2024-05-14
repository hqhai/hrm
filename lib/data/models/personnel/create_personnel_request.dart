import 'package:json_annotation/json_annotation.dart';

part 'create_personnel_request.g.dart';

@JsonSerializable()
class CreatePersonnelRequest {
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

  const CreatePersonnelRequest(
      {this.code,
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
        this.afternoonEndTime,});

  factory CreatePersonnelRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePersonnelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePersonnelRequestToJson(this);
}
