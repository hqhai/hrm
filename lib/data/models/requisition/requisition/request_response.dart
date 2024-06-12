import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_response.g.dart';

@JsonSerializable()
class RequestsResponse {
  final List<Request> requests;
  final int totalItems;

  const RequestsResponse({
    this.totalItems = 0,
    this.requests = const [],
  });

  factory RequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsResponseToJson(this);
}
