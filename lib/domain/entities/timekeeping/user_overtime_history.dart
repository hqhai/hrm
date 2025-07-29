import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overtime_history.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class UserOverTimeHistoryModel {
  /// hệ số

  final double overTimeRate;

  //
  // /// số công tíng lương chưa nhân hệ số
  //
  // final double overTimeSalaryDefault;

  /// số công tính lương đã nhân hệ số

  final double overTimeSalaryMultiplier;

  //
  // /// số công tính nghỉ bù chưa nhân hệ số
  //
  // final double overTimeLeaveDefault;

  /// số công tính nghỉ bù đã nhân hệ số

  final double overTimeLeaveMultiplier;

  /// kiểu ngày nghỉ

  @JsonKey(unknownEnumValue: EnumOvertimeDay.unknown)
  final EnumOvertimeDay overTimeDay;

  /// bắt đầu

  final int startTime;

  /// kết thúc

  final int endTime;

  /// số giờ tăng ca

  final bool isChecking;

  const UserOverTimeHistoryModel({
    this.startTime = 0,
    this.endTime = 0,
    this.isChecking = true,
    this.overTimeDay = EnumOvertimeDay.unknown,
    this.overTimeRate = 0,
    // this.overTimeLeaveDefault = 0,
    this.overTimeLeaveMultiplier = 0,
    // this.overTimeSalaryDefault = 0,
    this.overTimeSalaryMultiplier = 0,
  });

  factory UserOverTimeHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserOverTimeHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserOverTimeHistoryModelToJson(this);
}
