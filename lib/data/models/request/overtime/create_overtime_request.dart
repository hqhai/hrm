import 'package:base_app/data/models/request/overtime/list_request_types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_overtime_request.g.dart';

@JsonSerializable()
class CreateOverTimeRequest {
  final String type;
  final bool isApprove;
  final ListRequestTypes? config;

  const CreateOverTimeRequest(
      {required this.type, required this.isApprove, this.config = const ListRequestTypes()});

  factory CreateOverTimeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOverTimeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOverTimeRequestToJson(this);
}
