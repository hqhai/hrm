import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_shift_state.g.dart';

@CopyWith()
@JsonSerializable()
class LeaveShiftState extends Equatable {
  final Map<String, WorkShiftRegisteredDetail> workShifts;
  final List<int> keys;
  final Map<int, List<String>> mapKeyDate;

  const LeaveShiftState(
      {this.workShifts = const {},
      this.mapKeyDate = const {},
      this.keys = const []});

  @override
  List<Object> get props => [workShifts, mapKeyDate, keys];

  factory LeaveShiftState.fromJson(Map<String, dynamic> json) => _$LeaveShiftStateFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveShiftStateToJson(this);
}
