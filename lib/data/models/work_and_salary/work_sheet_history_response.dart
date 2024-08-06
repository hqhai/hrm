import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_sheet_history_response.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class WorkSheetHistoryResponse {
  final Map<int, AttendanceByDate> attendances;
  final List<int> keys;

  const WorkSheetHistoryResponse({
    this.attendances = const {},
    this.keys = const [],
  });

  factory WorkSheetHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkSheetHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSheetHistoryResponseToJson(this);
}
