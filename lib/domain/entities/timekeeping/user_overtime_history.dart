import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overtime_history.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class UserOverTimeHistoryModel {
  /// <summary>
  /// hệ số
  /// </summary>
  final double overTimeRate;

  /// <summary>
  /// số công tíng lương chưa nhân hệ số
  /// </summary>
  final double overTimeSalaryDefault;

  /// <summary>
  /// số công tính lương đã nhân hệ số
  /// </summary>
  final double overTimeSalaryMultiplier;

  /// <summary>
  /// số công tính nghỉ bù chưa nhân hệ số
  /// </summary>
  final double overTimeLeaveDefault;

  /// <summary>
  /// số công tính nghỉ bù đã nhân hệ số
  /// </summary>
  final double overTimeLeaveMultiplier;

  /// <summary>
  /// kiểu ngày nghỉ
  /// </summary>
  final EnumOvertimeDay? overTimeDay;

  /// <summary>
  /// bắt đầu
  /// </summary>
  final int startTime;

  /// <summary>
  /// kết thúc
  /// </summary>
  final int endTime;

  /// <summary>
  /// số giờ tăng ca
  /// </summary>
  final bool isChecking;

  const UserOverTimeHistoryModel({
    this.startTime = 0,
    this.endTime = 0,
    this.isChecking = true,
    this.overTimeDay,
    this.overTimeRate = 0,
    this.overTimeLeaveDefault = 0,
    this.overTimeLeaveMultiplier = 0,
    this.overTimeSalaryDefault = 0,
    this.overTimeSalaryMultiplier = 0,
  });

  factory UserOverTimeHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserOverTimeHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserOverTimeHistoryModelToJson(this);
}
