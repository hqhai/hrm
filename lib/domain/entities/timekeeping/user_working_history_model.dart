import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/timekeeping/user_overtime_history.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_working_history_model.g.dart';

@JsonSerializable()
@CopyWith()
@CustomDateTimeConverter()
class UserWorkingHistoryModel {
  /// id của nhân sự

  final String userId;

  /// ngày checking

  final DateTime? date;

  /// trạng thái của ngày

  final List<UserWorkingHistoryStatus> status;

  /// công chuẩn

  final double realRate;

  /// công thực tế

  final double actualRate;

  /// công nghỉ phép

  final double leaveRate;

  /// công nghỉ lễ

  final double holidayRate;

  /// công không tính lương

  final double noSalaryRate;

  /// số giờ tăng ca

  final double overTime;

  /// hệ số

  final double overTimeRate;

  /// loại tăng ca

  @JsonKey(unknownEnumValue: EnumOvertimeDay.unknown)
  final EnumOvertimeDay overTimeDay;

  /// số giờ thực tế

  final double workTimeActual;

  /// số giờ chuẩn

  final double workTimeReal;

  /// số phút về sớm

  final double timeEarly;

  /// số phút đi muộn

  final double timeLate;

  /// công được tính lương

  final double salaryRate;

  /// các đơn từ

  final List<String> requestIds;

  /// ca làm việc

  final List<String> workShiftIds;

  /// ca chi tiết

  final String workShiftDetailId;

  /// giờ checkin

  final int? checkIn;

  /// giờ checkout

  final int? checkOut;

  /// Tổng thời gian làm bù

  final int makeUpTime;

  /// OT trong bảng công

  final List<UserOverTimeHistoryModel> userOverTimeHistories;

  const UserWorkingHistoryModel({
    this.userOverTimeHistories = const [],
    this.checkIn,
    this.date,
    this.checkOut,
    this.timeEarly = 0,
    this.timeLate = 0,
    this.overTime = 0,
    this.status = const [],
    this.userId = '',
    this.actualRate = 0,
    this.holidayRate = 0,
    this.leaveRate = 0,
    this.noSalaryRate = 0,
    this.overTimeDay = EnumOvertimeDay.unknown,
    this.overTimeRate = 0,
    this.realRate = 0,
    this.requestIds = const [],
    this.salaryRate = 0,
    this.workShiftDetailId = '0',
    this.workShiftIds = const [],
    this.workTimeActual = 0,
    this.workTimeReal = 0,
    this.makeUpTime = 0,
  });

  factory UserWorkingHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$UserWorkingHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserWorkingHistoryModelToJson(this);
}
