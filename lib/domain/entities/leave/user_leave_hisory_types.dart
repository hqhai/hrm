import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave_hisory_types.g.dart';

@CopyWith()
@JsonSerializable()
class UserLeaveHistoryTypes {
  final TypeLeaveEnum type;
  final double total;
  final double totalExpired;
  final double totalUsed;
  final double totalRemaining;

  const UserLeaveHistoryTypes({
    this.type = TypeLeaveEnum.seniorityLeave,
    this.total = 0,
    this.totalExpired = 0,
    this.totalRemaining = 0,
    this.totalUsed = 0,
  });

  factory UserLeaveHistoryTypes.fromJson(Map<String, dynamic> json) =>
      _$UserLeaveHistoryTypesFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveHistoryTypesToJson(this);
}
