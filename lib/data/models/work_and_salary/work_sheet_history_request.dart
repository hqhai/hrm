import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_sheet_history_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class WorkSheetHistoryRequest {
  final DateTime? date;
  final String userId;

  const WorkSheetHistoryRequest({this.date, this.userId = ''});

  factory WorkSheetHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkSheetHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSheetHistoryRequestToJson(this);
}
