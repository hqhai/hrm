import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_sheet.g.dart';

@CopyWith()
@JsonSerializable()
class WorkSheet {
  /// <summary>
  /// công thực tế
  /// </summary>
  final double actualWork;

  /// <summary>
  /// công nghỉ phép
  /// </summary>
  final double leaveWork;

  /// <summary>
  /// công nghỉ lễ
  /// </summary>
  final double holidayWork;

  /// <summary>
  /// nghỉ không lương
  /// </summary>
  final double noSalaryWork;

  /// <summary>
  /// số giờ OT
  /// </summary>
  final int overTime;

  /// <summary>
  /// số giờ làm việc
  /// </summary>
  final int workTime;

  /// <summary>
  /// số phút đi sớm
  /// </summary>
  final int timeEarly;

  /// <summary>
  /// số phút đến muộn
  /// </summary>
  final int timeLate;

  /// <summary>
  /// công tính lương
  /// </summary>
  final double salaryWork;

  /// <summary>
  /// công chuẩn
  /// </summary>
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

  factory WorkSheet.fromJson(Map<String, dynamic> json) => _$WorkSheetFromJson(json);

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
