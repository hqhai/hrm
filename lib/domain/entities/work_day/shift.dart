import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/work_day/work_shift_approve.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class Shift {
  final String id;
  final int startTime;
  final int endTime;
  final int checkInStartTimeValid;
  final int checkInEndTimeValid;
  final int checkOutStartTimeValid;
  final int checkOutEndTimeValid;
  final String code;
  final String name;
  final WorkShiftApprove workShiftApprove;
  final DateTime? createdDate;
  final DateTime? workDate;
  final ShiftType type;
  final WorkShiftRequestStatus status;
  final int workEffort;

  const Shift({
    this.id = '',
    this.createdDate,
    this.type = ShiftType.administrativeShift,
    this.name = '',
    this.endTime = 0,
    this.startTime = 0,
    this.code = '',
    this.checkInEndTimeValid = 0,
    this.checkInStartTimeValid = 0,
    this.checkOutEndTimeValid = 0,
    this.checkOutStartTimeValid = 0,
    this.status = WorkShiftRequestStatus.pending,
    this.workShiftApprove = const WorkShiftApprove(),
    this.workEffort = 1,
    this.workDate,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
