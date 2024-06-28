import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_end.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class StartEndResponse {
  final DateTime? startTime;
  final DateTime? endTime;

  const StartEndResponse(
      {this.startTime , this.endTime});

  factory StartEndResponse.fromJson(Map<String, dynamic> json) =>
      _$StartEndResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StartEndResponseToJson(this);
}
