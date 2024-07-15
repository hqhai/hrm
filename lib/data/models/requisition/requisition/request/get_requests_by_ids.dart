import 'package:json_annotation/json_annotation.dart';

part 'get_requests_by_ids.g.dart';

@JsonSerializable()
class GetRequestsByIds {
  final List<String> ids;

  const GetRequestsByIds({
    this.ids = const []
  });

  factory GetRequestsByIds.fromJson(Map<String, dynamic> json) =>
      _$GetRequestsByIdsFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestsByIdsToJson(this);
}
