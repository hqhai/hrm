import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shift_registered_details.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class WorkShiftRegisteredDetail extends Equatable {
  final String workShiftSettingDetailId;
  final String workShiftDetailId;
  final DateTime workDate;
  final double workEffort;
  final String nameWorkShift;
  final int startTime;
  final int endTime;
  final int numberTime;

  const WorkShiftRegisteredDetail({
    this.workShiftSettingDetailId = '',
    this.workShiftDetailId = '',
    required this.workDate,
    this.workEffort = 0,
    this.nameWorkShift = '',
    this.endTime = 0,
    this.startTime = 0,
    this.numberTime = 0,
  });

  factory WorkShiftRegisteredDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftRegisteredDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftRegisteredDetailToJson(this);

  @override
  List<Object> get props => [
        workShiftSettingDetailId,
        workShiftDetailId,
        workDate,
        workEffort,
        nameWorkShift,
        startTime,
        endTime,
        numberTime
      ];
}
