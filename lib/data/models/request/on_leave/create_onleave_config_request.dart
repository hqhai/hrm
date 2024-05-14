import 'package:json_annotation/json_annotation.dart';

part 'create_onleave_config_request.g.dart';

@JsonSerializable()
class CreateOnLeaveConfigRequest {
  final String startOnLeave;
  final String endOnLeave;

  const CreateOnLeaveConfigRequest(
      {
        this.endOnLeave = '',
        this.startOnLeave = '',
      });

  factory CreateOnLeaveConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOnLeaveConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOnLeaveConfigRequestToJson(this);
}
