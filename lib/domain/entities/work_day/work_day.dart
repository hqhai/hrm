import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/entities/work_day/work_shift_approve.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_day.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class WorkDay {
  final String id;
  final WorkShiftRequestStatus status;
  final WeekDayEnum dayOfWeek;
  final DateTime? workDate;
  final List<WorkShiftApprove> workShiftApproves;
  final WorkShiftApprove workShiftApprove;
  final String createdUserId;
  final String createdFullName;
  final DateTime? createdDate;
  final List<Shift> items;

  const WorkDay({
    this.id = '',
    this.createdFullName = '',
    this.createdUserId = '',
    this.status = WorkShiftRequestStatus.pending,
    this.createdDate,
    this.items = const [],
    this.workDate,
    this.workShiftApprove = const WorkShiftApprove(),
    this.workShiftApproves = const [],
    this.dayOfWeek = WeekDayEnum.monday,
  });

  factory WorkDay.fromJson(Map<String, dynamic> json) => _$WorkDayFromJson(json);

  Map<String, dynamic> toJson() => _$WorkDayToJson(this);
}
