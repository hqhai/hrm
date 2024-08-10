import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'explanation.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
@CopyWith()
class Explanation extends Equatable {
  final String note;
  final DateTime? workDate;
  final String workShiftSettingDetailId;
  final String workShiftDetailId;
  final int startTime;
  final int endTime;

  const Explanation({
    this.note = '',
    this.workDate,
    this.startTime = 0,
    this.workShiftSettingDetailId = '',
    this.workShiftDetailId = '',
    this.endTime = 0,
  });

  factory Explanation.fromJson(Map<String, dynamic> json) => _$ExplanationFromJson(json);

  Map<String, dynamic> toJson() => _$ExplanationToJson(this);

  @override
  List<Object?> get props => [
        note,
        workDate,
        workShiftSettingDetailId,
        workShiftDetailId,
        startTime,
        endTime,
      ];
}
