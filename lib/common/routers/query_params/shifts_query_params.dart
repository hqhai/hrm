import 'package:base_app/common/enum/user_type.dart';
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

@JsonSerializable()
class ShiftsBuyUserQueryParams {
  final UserType type;

  ShiftsBuyUserQueryParams({
    required this.type,
  });

  factory ShiftsBuyUserQueryParams.fromJson(Map<String, dynamic> json) =>
      _$ShiftsBuyUserQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsBuyUserQueryParamsToJson(this);
}

@JsonSerializable()
class ShiftsReviewQueryParams {
  final String id;
  final DateTime? startTime;
  final DateTime? endTime;

  ShiftsReviewQueryParams({
    required this.id,
    this.startTime,
    this.endTime,
  });

  factory ShiftsReviewQueryParams.fromJson(Map<String, dynamic> json) =>
      _$ShiftsReviewQueryParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftsReviewQueryParamsToJson(this);
}
