import 'package:json_annotation/json_annotation.dart';

part 'flow_by_id_request.g.dart';

@JsonSerializable()
class FlowByIdRequest {
  final String id;

  const FlowByIdRequest({
    this.id = ''
  });

  factory FlowByIdRequest.fromJson(Map<String, dynamic> json) =>
      _$FlowByIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FlowByIdRequestToJson(this);
}
