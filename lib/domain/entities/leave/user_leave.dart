import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_leave.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class UserLeave {
  final String userId;
  final String userName;
  final String code;
  final String positionId;
  final String namePosition;
  final String departmentId;
  final String nameDepartment;
  final double total;
  final double totalExpired;
  final double totalUsed;
  final double totalRemaining;
  final List<UserLeaveHistoryTypes> userLeaveHistoryTypes;

  const UserLeave({
    this.userId = '',
    this.totalUsed = 0,
    this.totalRemaining = 0,
    this.totalExpired = 0,
    this.total = 0,
    this.nameDepartment = '',
    this.departmentId = '',
    this.code = '',
    this.userName = '',
    this.positionId = '',
    this.namePosition = '',
    this.userLeaveHistoryTypes = const [],
  });

  factory UserLeave.fromJson(Map<String, dynamic> json) => _$UserLeaveFromJson(json);

  Map<String, dynamic> toJson() => _$UserLeaveToJson(this);
}
