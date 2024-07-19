import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class Shift {
  final String id;
  final DateTime? startTime;
  final DateTime? endTime;
  final String code;
  final DateTime? dateTime;

  const Shift({
    this.id = '',
    this.dateTime,
    this.startTime,
    this.endTime,
    this.code = '',
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
