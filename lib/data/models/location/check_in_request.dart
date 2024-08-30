import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_in_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class CheckInRequest {
  final double longitude;
  final double latitude;
  final List<String> scheduleSchoolIds;


  const CheckInRequest({
    required this.longitude,
    required this.latitude,
    required this.scheduleSchoolIds,

  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);
}
