import 'package:json_annotation/json_annotation.dart';

part 'get_attendances_request.g.dart';

@JsonSerializable()
class GetAttendanceRequest {
  final String startDate;
  final String endDate;
  final String email;

  const GetAttendanceRequest({required this.startDate, required this.endDate, required this.email});

  factory GetAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAttendanceRequestToJson(this);
}