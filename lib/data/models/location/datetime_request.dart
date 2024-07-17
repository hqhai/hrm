import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'datetime_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class DatetimeRequest {
  final DateTime workDate;

  const DatetimeRequest({
    required this.workDate
  });

  factory DatetimeRequest.fromJson(Map<String, dynamic> json) => _$DatetimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DatetimeRequestToJson(this);
}
