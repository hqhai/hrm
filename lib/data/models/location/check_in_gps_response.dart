import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_in_gps_response.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class CheckInGPSResponse {
  final bool checkIn;

  const CheckInGPSResponse({
    this.checkIn = false,
  });

  factory CheckInGPSResponse.fromJson(Map<String, dynamic> json) => _$CheckInGPSResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInGPSResponseToJson(this);
}
