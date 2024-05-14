import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_onleave_request.g.dart';

@JsonSerializable()
class CreateOnLeaveRequest {
  final String type;
  final bool isApprove;
  final String priority;
  final String? title;
  final String? content;
  final CreateOnLeaveConfigRequest? config;

  const CreateOnLeaveRequest(
      {required this.type,
      required this.isApprove,
      required this.priority,
      this.content,
      this.title,
      this.config = const CreateOnLeaveConfigRequest()});

  factory CreateOnLeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOnLeaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOnLeaveRequestToJson(this);
}
