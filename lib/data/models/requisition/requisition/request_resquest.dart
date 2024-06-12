import 'package:json_annotation/json_annotation.dart';

part 'request_request.g.dart';

@JsonSerializable()
class RequestsRequest {
  final int page;

  const RequestsRequest({
    this.page = 0
  });

  factory RequestsRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsRequestToJson(this);
}
