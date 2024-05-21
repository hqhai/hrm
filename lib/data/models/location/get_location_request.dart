import 'package:json_annotation/json_annotation.dart';

part 'get_location_request.g.dart';

@JsonSerializable()
class GetLocationRequest {
  final String locationType;
  final int pageSize;
  final int page;
  final String? parentId;

  const GetLocationRequest({
    required this.locationType,
    required this.pageSize,
    required this.page,
    this.parentId,
  });

  factory GetLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetLocationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetLocationRequestToJson(this);
}
