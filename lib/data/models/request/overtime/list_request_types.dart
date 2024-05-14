import 'package:base_app/data/models/request/overtime/create_overtime_config_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_request_types.g.dart';

@JsonSerializable()
class ListRequestTypes {
  final List<CreateOverTimeConfigRequest>? listRequestTypes;

  const ListRequestTypes(
      {this.listRequestTypes = const []});

  factory ListRequestTypes.fromJson(Map<String, dynamic> json) =>
      _$ListRequestTypesFromJson(json);

  Map<String, dynamic> toJson() => _$ListRequestTypesToJson(this);
}
