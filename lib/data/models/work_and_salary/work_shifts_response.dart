import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shifts_response.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class WorkShiftsResponse {
  final DateTime? workDate;
  final List<WorkShiftRegisteredDetail> workShiftRegisteredDetails;

  const WorkShiftsResponse(
      {this.workDate , this.workShiftRegisteredDetails = const []});

  factory WorkShiftsResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkShiftsResponseToJson(this);
}
