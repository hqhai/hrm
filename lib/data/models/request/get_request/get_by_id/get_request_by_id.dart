import 'package:json_annotation/json_annotation.dart';

part 'get_request_by_id.g.dart';

@JsonSerializable()
class GetRequestRequestById {
  final String id;

  const GetRequestRequestById({required this.id});

  factory GetRequestRequestById.fromJson(Map<String, dynamic> json) =>
      _$GetRequestRequestByIdFromJson(json);
  Map<String, dynamic> toJson() => _$GetRequestRequestByIdToJson(this);
}