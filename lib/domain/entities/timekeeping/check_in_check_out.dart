
import 'package:json_annotation/json_annotation.dart';

part 'check_in_check_out.g.dart';

@JsonSerializable()
class CheckInCheckOut {
  final int? startTime;
  final int? endTime;

  const CheckInCheckOut({
    this.startTime,
    this.endTime,
  });

  factory CheckInCheckOut.fromJson(Map<String, dynamic> json) => _$CheckInCheckOutFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInCheckOutToJson(this);
}
