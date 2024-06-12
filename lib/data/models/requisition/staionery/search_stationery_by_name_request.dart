import 'package:json_annotation/json_annotation.dart';

part 'search_stationery_by_name_request.g.dart';

@JsonSerializable()
class SearchStationeryByNameRequest {
  final String fullName;
  final int page;

  const SearchStationeryByNameRequest({
    this.fullName = '',
    this.page = 0
  });

  factory SearchStationeryByNameRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchStationeryByNameRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStationeryByNameRequestToJson(this);
}
