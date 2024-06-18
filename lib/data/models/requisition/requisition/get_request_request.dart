import 'package:json_annotation/json_annotation.dart';

part 'get_request_request.g.dart';

@JsonSerializable()
class GetRequestRequest {
  final int page;

  const GetRequestRequest({
    this.page = 1
  });

  factory GetRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestRequestToJson(this);
}
