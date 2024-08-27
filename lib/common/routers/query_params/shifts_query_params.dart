import 'package:json_annotation/json_annotation.dart';

part 'shifts_query_params.g.dart';

@JsonSerializable()
class ShiftsQueryParams {
  final DateTime date;
  final String id;

  ShiftsQueryParams({
    required this.id,
    required this.date,
  });

  factory ShiftsQueryParams.fromJson(Map<String, dynamic> json) =>
      _$ShiftsQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsQueryParamsToJson(this);
}
