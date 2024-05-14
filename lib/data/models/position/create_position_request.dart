import 'package:json_annotation/json_annotation.dart';

part 'create_position_request.g.dart';

@JsonSerializable()
class CreatePositionRequest {
  final String name;
  final String? description;

  const CreatePositionRequest({
    required this.name,
    this.description,
  });

  factory CreatePositionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePositionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePositionRequestToJson(this);
}
