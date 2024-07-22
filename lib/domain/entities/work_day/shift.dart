import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/date_time_json.dart';
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
  final String workShiftSettingId;
  final String workShiftId;
  final DateTime? createdDate;
  final ShiftType status;

  const Shift({
    this.id = '',
    this.createdDate,
    this.status = ShiftType.administrativeShift,
    this.name = '',
    this.endTime = 0,
    this.startTime = 0,
    this.code = '',
    this.workShiftId = '',
    this.checkInEndTimeValid = 0,
    this.checkInStartTimeValid = 0,
    this.checkOutEndTimeValid = 0,
    this.checkOutStartTimeValid = 0,
    this.workShiftSettingId = '',
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
