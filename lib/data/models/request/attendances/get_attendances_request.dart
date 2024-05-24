import 'package:json_annotation/json_annotation.dart';

part 'get_attendances_request.g.dart';

@JsonSerializable()
class GetAttendanceRequest {
  final String userid;
  final String year;
  final String month;


  const GetAttendanceRequest({required this.userid, required this.year, required this.month, });

  factory GetAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAttendanceRequestToJson(this);
}