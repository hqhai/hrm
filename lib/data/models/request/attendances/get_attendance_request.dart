import 'package:json_annotation/json_annotation.dart';

part 'get_attendance_request.g.dart';

@JsonSerializable()
class GetAttendancesRequest {
  final String userid;
  final String year;
  final String month;


  const GetAttendancesRequest({required this.userid, required this.year, required this.month, });

  factory GetAttendancesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAttendancesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAttendancesRequestToJson(this);
}

