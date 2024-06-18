import 'package:base_app/data/models/paging_infor_request.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_location_response.g.dart';

@JsonSerializable()
class GetLocationResponse {
  final List<Address> items;
  final PagingInfoRequest pagingInfo;

  const GetLocationResponse({
    this.items = const [],
    this.pagingInfo = const PagingInfoRequest(page: 1, totalItems: 0, pageSize: 0),
  });

  factory GetLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetLocationResponseToJson(this);
}
