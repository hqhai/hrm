import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_state.g.dart';

@CopyWith()
@JsonSerializable()
class ShiftState extends Equatable {
  final Map<String, Shift> mapShift;
  final Shift shift;
  final List<String> keys;

  const ShiftState({
    this.mapShift = const {},
    this.keys = const [],
    this.shift = const Shift(),
  });

  @override
  List<Object> get props => [shift, keys, mapShift];

  factory ShiftState.fromJson(Map<String, dynamic> json) => _$ShiftStateFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftStateToJson(this);
}
