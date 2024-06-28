import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_stationery_by_name_response.g.dart';

@JsonSerializable()
class SearchStationeryByNameResponse {
  final List<Stationery> items;
  final PagingInfoRequest pagingInfo;

  const SearchStationeryByNameResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(totalItems: 0, pageSize: 0, page: 1)
  });

  factory SearchStationeryByNameResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchStationeryByNameResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStationeryByNameResponseToJson(this);
}
