import 'package:json_annotation/json_annotation.dart';

part 'update_position_request.g.dart';

@JsonSerializable()
class UpdatePositionRequest {
  final String id;
  final String name;
  final String? description;

  const UpdatePositionRequest({
    required this.id,
    required this.name,
    this.description,
  });

  factory UpdatePositionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePositionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePositionRequestToJson(this);
}
