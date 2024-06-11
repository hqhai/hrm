import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_stationery_by_name_response.g.dart';

@JsonSerializable()
class SearchStationeryByNameResponse {
  final List<Stationery> stationery;
  final int totalItems;

  const SearchStationeryByNameResponse({
    this.stationery = const [],
    this.totalItems = 0
  });

  factory SearchStationeryByNameResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchStationeryByNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStationeryByNameResponseToJson(this);
}
