import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_explanation_request.g.dart';

@JsonSerializable()
class CreateExplanationRequest {
  final String type;
  final bool isApprove;
  final String priority;
  final String? title;
  final String? content;
  final CreateExplanationConfigRequest? config;

  const CreateExplanationRequest(
      {required this.type,
      required this.isApprove,
      required this.priority,
      this.content,
      this.title,
      this.config = const CreateExplanationConfigRequest()});

  factory CreateExplanationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExplanationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExplanationRequestToJson(this);
}
