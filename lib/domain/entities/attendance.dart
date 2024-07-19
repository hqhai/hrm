import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendance.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class Attendance {
  /// <summary>
  /// tên nhân viên
  /// </summary>
  final String? name;

  /// <summary>
  /// mã nhân viên
  /// </summary>
  final String? code;

  /// <summary>
  /// Id nhân viên
  /// </summary>
  final String? userId;

  /// <summary>
  /// công thực tế
  /// </summary>
  final double actualRate;

  /// <summary>
  /// công nghỉ phép
  /// </summary>
  final double leaveRate;

  /// <summary>
  /// công nghỉ lễ
  /// </summary>
  final double holidayRate;

  /// <summary>
  /// nghỉ không lương
  /// </summary>
  final double noSalaryRate;

  /// <summary>
  /// số giờ OT
  /// </summary>
  final int overTime;

  /// <summary>
  /// số công OT
  /// </summary>
  final int overTimeRate;

  /// <summary>
  /// số giờ OT
  /// </summary>
  final EnumOvertimeDay? overTimeDay;

  /// <summary>
  /// số giờ làm việc chuẩn
  /// </summary>
  final int workTimeReal;

  /// <summary>
  /// số giờ làm việc thực tế
  /// </summary>
  final int workTimeActual;

  /// <summary>
  /// số phút về sớm
  /// </summary>
  final int timeEarly;

  /// <summary>
  /// số phút đến muộn
  /// </summary>
  final int timeLate;

  /// <summary>
  /// số lần về sớm
  /// </summary>
  final int countEarly;

  /// <summary>
  /// số lần đến muộn
  /// </summary>
  final int countLate;

  /// <summary>
  /// công tính lương
  /// </summary>
  final double salaryWork;

  /// <summary>
  /// công chuẩn
  /// </summary>
  final double realRate;

  /// <summary>
  /// chi tiết từng ngày
  /// </summary>
  final List<UserWorkingHistoryModel> userWorkingHistories;

  const Attendance({
    this.workTimeReal = 0,
    this.workTimeActual = 0,
    this.overTime = 0,
    this.realRate = 0,
    this.overTimeRate = 0,
    this.overTimeDay,
    this.noSalaryRate = 0,
    this.leaveRate = 0,
    this.holidayRate = 0,
    this.actualRate = 0,
    this.userId,
    this.timeLate = 0,
    this.salaryWork = 0,
    this.name,
    this.code,
    this.countEarly = 0,
    this.countLate = 0,
    this.timeEarly = 0,
    this.userWorkingHistories = const [],
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);



  List<String> toListString() {
    return [
      realRate.toString(),///Công chuẩn
      actualRate.toString(),///Công thực tế
      leaveRate.toString(),///Công nghỉ
      holidayRate.toString(),///Công nghỉ lễ
      noSalaryRate.toString(),///Nghỉ không lương
      overTime.toString(),///Số giờ OT
      Duration(seconds: workTimeActual).inHours.toString(),///Số giờ làm việc
      Duration(seconds: timeLate).inMinutes.toString(),///Số phút đi muôn
      Duration(seconds: timeEarly).inMinutes.toString(),///Số phút về sớm
      countEarly.toString(),///Số lần về sớm
      countLate.toString(),///Số lần đi muộn
    ];
  }
}
