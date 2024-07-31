import 'package:json_annotation/json_annotation.dart';

part 'shifts_query_params.g.dart';

@JsonSerializable()
class ShiftsQueryParams {
  final DateTime date;

  ShiftsQueryParams({
    required this.date,
  });

  factory ShiftsQueryParams.fromJson(Map<String, dynamic> json) =>
      _$ShiftsQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsQueryParamsToJson(this);
}
