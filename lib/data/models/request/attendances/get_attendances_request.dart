import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_attendances_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetAttendanceRequest {
  final DateTime startDate;
  final DateTime endDate;

  const GetAttendanceRequest({
    required this.startDate,
    required this.endDate,
  });

  factory GetAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAttendanceRequestToJson(this);
}
