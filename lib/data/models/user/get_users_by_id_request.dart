import 'package:json_annotation/json_annotation.dart';

part 'get_users_by_id_request.g.dart';

@JsonSerializable()
class GetUsersByIdRequest {
  final List<String> ids;

  const GetUsersByIdRequest({
    this.ids = const [],
  });

  factory GetUsersByIdRequest.fromJson(Map<String, dynamic> json) =>
      _$GetUsersByIdRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetUsersByIdRequestToJson(this);
}
