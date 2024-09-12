import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/work_day/attendance_by_date.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_sheet_state.g.dart';

@CopyWith()
@JsonSerializable()
class WorkSheetState extends Equatable {
  final WorkSheet workSheet;
  final Map<int, AttendanceByDate> attendances;
  final List<int> keys;

  const WorkSheetState({
    this.workSheet = const WorkSheet(),
    this.attendances = const {},
    this.keys = const [],
  });

  @override
  List<Object> get props => [workSheet, attendances, keys];

  factory WorkSheetState.fromJson(Map<String, dynamic> json) => _$WorkSheetStateFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSheetStateToJson(this);
}
