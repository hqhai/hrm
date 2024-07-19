import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_work_sheet_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetWorkSheetRequest {
  final DateTime time;

  const GetWorkSheetRequest({required this.time,});

  factory GetWorkSheetRequest.fromJson(Map<String, dynamic> json) =>
      _$GetWorkSheetRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetWorkSheetRequestToJson(this);
}