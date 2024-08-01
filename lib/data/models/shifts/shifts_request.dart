import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shifts_request.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class ShiftsRequest {
  final DateTime? startTime;
  final DateTime? endTime;

  const ShiftsRequest({
    this.startTime,
    this.endTime,
  });

  factory ShiftsRequest.fromJson(Map<String, dynamic> json) => _$ShiftsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsRequestToJson(this);
}
