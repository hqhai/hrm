import 'package:json_annotation/json_annotation.dart';

part 'create_explanation_config_request.g.dart';

@JsonSerializable()
class CreateExplanationConfigRequest {
  final String lateDay;

  const CreateExplanationConfigRequest(
      {
        this.lateDay = '',
      });

  factory CreateExplanationConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExplanationConfigRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateExplanationConfigRequestToJson(this);
}
