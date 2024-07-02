import 'package:json_annotation/json_annotation.dart';

part 'leave_day.g.dart';

@JsonSerializable()
class LeaveDayResponse {
  final double permission;
  final double used;
  final double remaining;

  const LeaveDayResponse(
      {this.permission = 0, this.used = 0, this.remaining = 0});

  factory LeaveDayResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveDayResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LeaveDayResponseToJson(this);
}
