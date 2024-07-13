import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_working_history_model.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class UserWorkingHistoryModel {
  /// <summary>
  /// id của nhân sự
  /// </summary>
  final String userId;

  /// <summary>
  /// ngày checking
  /// </summary>
  final DateTime? date;

  /// <summary>
  /// trạng thái của ngày
  /// </summary>
  final List<UserWorkingHistoryStatus>? status;

  /// <summary>
  /// công chuẩn
  /// </summary>
  final double? realRate;

  /// <summary>
  /// công thực tế
  /// </summary>
  final double? actualRate;

  /// <summary>
  /// công nghỉ phép
  /// </summary>
  final double? leaveRate;

  /// <summary>
  /// công nghỉ lễ
  /// </summary>
  final double? holidayRate;

  /// <summary>
  /// công không tính lương
  /// </summary>
  final double? noSalaryRate;

  /// <summary>
  /// số giờ tăng ca
  /// </summary>
  final double? overTime;

  /// <summary>
  /// hệ số
  /// </summary>
  final double? overTimeRate;

  /// <summary>
  /// loại tăng ca
  /// </summary>
  final EnumOvertimeDay? overTimeDay;

  /// <summary>
  /// số giờ thực tế
  /// </summary>
  final double? workTimeActual;

  /// <summary>
  /// số giờ chuẩn
  /// </summary>
  final double? workTimeReal;

  /// <summary>
  /// số phút về sớm
  /// </summary>
  final double? timeEarly;

  /// <summary>
  /// số phút đi muộn
  /// </summary>
  final double? timeLate;

  /// <summary>
  /// công được tính lương
  /// </summary>
  final double? salaryRate;

  /// <summary>
  /// các đơn từ
  /// </summary>
  final List<String>? requestIds;

  /// <summary>
  /// ca làm việc
  /// </summary>
  final String? workShiftId;

  /// <summary>
  /// ca chi tiết
  /// </summary>
  final String? workShiftDetailId;

  /// <summary>
  /// giờ checkin
  /// </summary>
  final int? checkIn;

  /// <summary>
  /// giờ checkout
  /// </summary>
  final int? checkOut;

  const UserWorkingHistoryModel({
    this.checkIn,
    this.date,
    this.checkOut,
    this.timeEarly,
    this.timeLate,
    this.overTime,
    this.status,
    this.userId = '',
    this.actualRate,
    this.holidayRate,
    this.leaveRate,
    this.noSalaryRate,
    this.overTimeDay,
    this.overTimeRate,
    this.realRate,
    this.requestIds,
    this.salaryRate,
    this.workShiftDetailId,
    this.workShiftId,
    this.workTimeActual,
    this.workTimeReal,
  });

  factory UserWorkingHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserWorkingHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserWorkingHistoryModelToJson(this);
}
