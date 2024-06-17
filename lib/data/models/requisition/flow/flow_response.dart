import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow_response.g.dart';

@JsonSerializable()
class FlowResponse {
  final int totalItems;
  final List<FlowRequest> flows;

  const FlowResponse({
    this.totalItems = 0,
    this.flows = const [],
  });

  factory FlowResponse.fromJson(Map<String, dynamic> json) =>
      _$FlowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlowResponseToJson(this);
}
