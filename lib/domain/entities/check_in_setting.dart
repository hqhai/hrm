import 'package:json_annotation/json_annotation.dart';
part 'check_in_setting.g.dart';

@JsonSerializable()
class CheckInSetting {
  final int morningStartTime;
  final int morningEndTime;
  final int afternoonStartTime;
  final int afternoonEndTime;
  final String departmentId;
  final String? userId;
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String createdFullName;
  final String? updatedFullName;
  final String createdDate;
  final String? updatedDate;

  const CheckInSetting({
    required this.morningStartTime,
    required this.morningEndTime,
    required this.afternoonStartTime,
    required this.afternoonEndTime,
    required this.departmentId,
    required this.id,
    required this.createdUserId,
    this.updatedUserId,
    required this.createdFullName,
    this.updatedFullName,
    required this.createdDate,
    this.updatedDate,
    this.userId,
  });

  factory CheckInSetting.fromJson(Map<String, dynamic> json) => _$CheckInSettingFromJson(json);
  Map<String, dynamic> toJson() => _$CheckInSettingToJson(this);
}
