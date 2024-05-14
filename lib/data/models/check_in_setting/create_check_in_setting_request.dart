import 'package:json_annotation/json_annotation.dart';

part 'create_check_in_setting_request.g.dart';

@JsonSerializable()
class CreateCheckInSettingRequest {
  final int morningStartTime;
  final int morningEndTime;
  final int afternoonStartTime;
  final int afternoonEndTime;
  final String departmentId;

  const CreateCheckInSettingRequest(
      {
        required this.morningStartTime,
        required this.morningEndTime,
        required this.afternoonStartTime,
        required this.afternoonEndTime,
        required this.departmentId,
        });

  factory CreateCheckInSettingRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCheckInSettingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCheckInSettingRequestToJson(this);
}
