import 'package:json_annotation/json_annotation.dart';

part 'get_request.g.dart';

@JsonSerializable()
class GetRequestRequest {
  final String status;
  final int page;

  const GetRequestRequest({required this.status, required this.page});

  factory GetRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetRequestRequestToJson(this);
}