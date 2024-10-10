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
  final String workShiftSettingDetailId;
  final String code;
  final String name;
  final List<WorkShiftApprove> workShiftApproves;
  final DateTime? createdDate;
  final DateTime? workDate;
  final int validRegistTime;
  final String validRegistTimeType;
  @JsonKey(unknownEnumValue: ShiftType.unknown)
  final ShiftType type;
  @JsonKey(unknownEnumValue: WorkShiftRequestStatus.unknown)
  final WorkShiftRequestStatus status;
  final double workEffort;

  const Shift({
    this.workShiftSettingDetailId = '',
    this.id = '',
    this.createdDate,
    this.type = ShiftType.unknown,
    this.name = '',
    this.endTime = 0,
    this.startTime = 0,
    this.code = '',
    this.checkInEndTimeValid = 0,
    this.checkInStartTimeValid = 0,
    this.checkOutEndTimeValid = 0,
    this.checkOutStartTimeValid = 0,
    this.status = WorkShiftRequestStatus.unknown,
    this.workShiftApproves = const [],
    this.workEffort = 1,
    this.workDate,
    this.validRegistTime = 0,
    this.validRegistTimeType = ''
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
