import 'package:json_annotation/json_annotation.dart';

part 'information_request_extra.g.dart';

@JsonSerializable()
class InformationRequestExtra {
  final String flowId;
  final String requestId;
  final DateTime? date;

  const InformationRequestExtra({
    this.flowId = '',
    this.requestId = '',
    this.date,
  });

  factory InformationRequestExtra.fromJson(Map<String, dynamic> json) =>
      _$InformationRequestExtraFromJson(json);

  Map<String, dynamic> toJson() => _$InformationRequestExtraToJson(this);
}
