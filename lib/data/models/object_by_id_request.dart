import 'package:json_annotation/json_annotation.dart';

part 'object_by_id_request.g.dart';

@JsonSerializable()
class ObjectByIdRequest {
  final String id;

  const ObjectByIdRequest(
      {required this.id,});

  factory ObjectByIdRequest.fromJson(Map<String, dynamic> json) =>
      _$ObjectByIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectByIdRequestToJson(this);
}
