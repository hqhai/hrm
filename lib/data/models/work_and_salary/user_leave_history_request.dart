import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave_history_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class UserLeaveHistoryRequest {
  final DateTime? date;
  final TypeLeaveEnum? type;
  final int? page;

  const UserLeaveHistoryRequest({
    this.page,
    this.type,
    this.date
  });

  factory UserLeaveHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$UserLeaveHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveHistoryRequestToJson(this);
}
