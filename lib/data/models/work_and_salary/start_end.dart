import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'start_end.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class StartEndResponse {
  final DateTime? startDate;
  final DateTime? endDate;

  const StartEndResponse(
      {this.startDate , this.endDate});

  factory StartEndResponse.fromJson(Map<String, dynamic> json) =>
      _$StartEndResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StartEndResponseToJson(this);
}
