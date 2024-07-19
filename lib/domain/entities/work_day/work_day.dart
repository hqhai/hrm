import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_day.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class WorkDay {
  final String id;
  final DateTime? date;
  final List<Shift> shifts;

  const WorkDay({
    this.id = '',
    this.date,
    this.shifts = const [],
  });

  factory WorkDay.fromJson(Map<String, dynamic> json) => _$WorkDayFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayToJson(this);
}
