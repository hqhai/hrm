import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_units.g.dart';

@JsonSerializable()
@CopyWith()
class DateUnits {
  final String date;
  final int? startTime;
  final int? endTime;
  final String? note;

  const DateUnits({this.date = '', this.startTime = 0, this.endTime = 0, this.note});

  factory DateUnits.fromJson(Map<String, dynamic> json) => _$DateUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$DateUnitsToJson(this);
}
