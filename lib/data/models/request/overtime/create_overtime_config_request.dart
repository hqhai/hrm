import 'package:json_annotation/json_annotation.dart';

part 'create_overtime_config_request.g.dart';

@JsonSerializable()
class CreateOverTimeConfigRequest {
  final int totalTime;
  final String startOverTime;
  final String endOverTime;
  final String project;
  final String task;

  const CreateOverTimeConfigRequest(
      {
        this.project = '',
        this.task = '',
        this.endOverTime = '',
        this.startOverTime = '',
        this.totalTime = 0,
      });

  factory CreateOverTimeConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOverTimeConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOverTimeConfigRequestToJson(this);
}
