import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave_history.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class UserLeaveHistory {
  final String id;
  final String userId;
  final TypeLeaveEnum type;
  final TimeUnitEnum timeUnit;
  final double initialValue;
  final double changeValue;
  final double remainValue;
  final double totalRemaining;
  final ChangeTypeEnum changeType;
  final String requestId;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  const UserLeaveHistory({
    this.id = '',
    this.type = TypeLeaveEnum.total,
    this.timeUnit = TimeUnitEnum.day,
    this.initialValue = 0,
    this.totalRemaining = 0,
    this.userId = '',
    this.updatedFullName = '',
    this.updatedUserId = '',
    this.updatedDate,
    this.createdDate,
    this.createdFullName = '',
    this.createdUserId = '',
    this.changeValue = 0,
    this.requestId = '',
    this.changeType = ChangeTypeEnum.subtraction,
    this.remainValue = 0,
  });

  factory UserLeaveHistory.fromJson(Map<String, dynamic> json) => _$UserLeaveHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveHistoryToJson(this);
}
