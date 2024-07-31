import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_shifts_map_keys.g.dart';

@JsonSerializable()
class WorkShiftsMapKeys {
  final List<int> keys;
  final Map<String, WorkShiftRegisteredDetail> mapWorkShift;
  final Map<int, List<String>> mapKeyDate;

  const WorkShiftsMapKeys({
    this.mapWorkShift = const {},
    this.keys = const [],
    this.mapKeyDate = const {},
  });

  factory WorkShiftsMapKeys.fromJson(Map<String, dynamic> json) =>
      _$WorkShiftsMapKeysFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShiftsMapKeysToJson(this);
}
