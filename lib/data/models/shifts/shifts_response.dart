import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shifts_response.g.dart';

@CopyWith()
@JsonSerializable()
class ShiftsResponse {
  final List<WorkDay> items;

  const ShiftsResponse({
   this.items = const [],
  });

  factory ShiftsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShiftsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsResponseToJson(this);
}
