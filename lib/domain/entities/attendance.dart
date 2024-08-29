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
  /// số giờ OT tính lương
  /// </summary>
  final int overTimeSalary;

  /// <summary>
  /// số giờ OT nghỉ bù
  /// </summary>
  final int overTimeLeave;

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

  const Attendance(
      {this.workTimeReal = 0,
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
      this.overTimeLeave = 0,
      this.overTimeSalary = 0});

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceToJson(this);

  List<String> toListString() {
    return [
      ///Công chuẩn
      realRate.toString(),

      ///Công thực tế
      actualRate.toString(),

      ///Công nghỉ
      leaveRate.toString(),

      ///Công nghỉ lễ
      holidayRate.toString(),

      ///Công tính lương
      salaryWork.toString(),

      ///Nghỉ không lương
      noSalaryRate.toString(),

      /*///Số giờ OT
      Duration(seconds: overTime).inHours.toString(),*/

      ///Số giờ OT tính lương
      Duration(seconds: overTimeSalary).inHours.toString(),

      ///Số giờ OT làm bù
      Duration(seconds: overTimeLeave).inHours.toString(),

      ///Số giờ làm việc
      Duration(seconds: workTimeActual).inHours.toString(),

      ///Số phút đi muôn
      Duration(seconds: timeLate).inMinutes.toString(),

      ///Số phút về sớm
      Duration(seconds: timeEarly).inMinutes.toString(),

      ///Số lần về sớm
      countEarly.toString(),

      ///Số lần đi muộn
      countLate.toString(),
    ];
  }
}
