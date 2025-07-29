import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_sheet.g.dart';

@CopyWith()
@JsonSerializable()
class WorkSheet {
  /// công thực tế

  final double actualWork;

  /// công nghỉ phép

  final double leaveWork;

  /// công nghỉ lễ

  final double holidayWork;

  /// nghỉ không lương

  final double noSalaryWork;

  /// số giờ OT

  final int overTime;

  /// số giờ làm việc

  final int workTime;

  /// số phút đi sớm

  final int timeEarly;

  /// số phút đến muộn

  final int timeLate;

  /// công tính lương

  final double salaryWork;

  /// công chuẩn

  final double realWork;

  const WorkSheet({
    this.realWork = 0,
    this.salaryWork = 0,
    this.timeEarly = 0,
    this.timeLate = 0,
    this.workTime = 0,
    this.noSalaryWork = 0,
    this.leaveWork = 0,
    this.actualWork = 0,
    this.overTime = 0,
    this.holidayWork = 0,
  });

  factory WorkSheet.fromJson(Map<String, dynamic> json) =>
      _$WorkSheetFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSheetToJson(this);

  List<String> toListString() {
    return [
      actualWork.toString(),
      leaveWork.toString(),
      holidayWork.toString(),
      noSalaryWork.toString(),
      overTime.toString(),
      workTime.toString(),
      timeEarly.toString(),
      timeLate.toString(),
      salaryWork.toString(),
      realWork.toString(),
    ];
  }
}
