import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class Attendance {
  /// tên nhân viên
  final String? name;

  /// mã nhân viên
  final String? code;

  /// Id nhân viên
  final String? userId;

  /// công thực tế

  final double actualRate;

  /// công nghỉ phép

  final double leaveRate;

  /// công nghỉ bù OT

  final double compensatoryLeaveRate;

  /// công nghỉ lễ

  final double holidayRate;

  /// nghỉ không lương

  final double noSalaryRate;

  /// số giờ OT

  final int overTime;

  /// số công OT

  final int overTimeRate;

  /// số giờ OT tính lương

  final int overTimeSalary;

  /// số giờ OT nghỉ bù

  final int overTimeLeave;

  /// số giờ OT

  @JsonKey(unknownEnumValue: EnumOvertimeDay.unknown)
  final EnumOvertimeDay overTimeDay;

  /// số giờ làm việc chuẩn

  final int workTimeReal;

  /// số giờ làm việc thực tế

  final int workTimeActual;

  /// số phút về sớm

  final int timeEarly;

  /// số phút đến muộn

  final int timeLate;

  /// số lần về sớm

  final int countEarly;

  /// số lần đến muộn

  final int countLate;

  /// công tính lương

  final double salaryRate;

  /// công chuẩn

  final double realRate;

  /// chi tiết từng ngày

  final List<UserWorkingHistoryModel> userWorkingHistories;

  const Attendance({
    this.workTimeReal = 0,
    this.workTimeActual = 0,
    this.overTime = 0,
    this.realRate = 0,
    this.overTimeRate = 0,
    this.overTimeDay = EnumOvertimeDay.unknown,
    this.noSalaryRate = 0,
    this.leaveRate = 0,
    this.holidayRate = 0,
    this.actualRate = 0,
    this.userId,
    this.timeLate = 0,
    this.salaryRate = 0,
    this.name,
    this.code,
    this.countEarly = 0,
    this.countLate = 0,
    this.timeEarly = 0,
    this.userWorkingHistories = const [],
    this.overTimeLeave = 0,
    this.overTimeSalary = 0,
    this.compensatoryLeaveRate = 0,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) =>
      _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);

  List<String> toListString() {
    return [
      ///Công chuẩn
      realRate.toString(),

      ///Công thực tế
      actualRate.toString(),

      ///Công nghỉ
      leaveRate.toString(),

      ///Cong nghi bu OT
      compensatoryLeaveRate.toString(),

      ///Công nghỉ lễ
      holidayRate.toString(),

      ///Công tính lương
      salaryRate.toString(),

      ///Nghỉ không lương
      noSalaryRate.toString(),

      ///Số giờ OT tính lương
      strTimeFromInt(overTimeSalary),

      ///Số giờ OT làm bù
      strTimeFromInt(overTimeLeave),

      ///Số giờ làm việc
      strTimeFromInt(workTimeActual),

      ///Số phút đi muôn
      Duration(seconds: timeLate).inMinutes.toString(),

      ///Số phút về sớm
      Duration(seconds: timeEarly).inMinutes.toString(),

      ///Số lần đi muộn
      countLate.toString(),

      ///Số lần về sớm
      countEarly.toString(),
    ];
  }
}
