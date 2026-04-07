import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_response.g.dart';

@JsonSerializable()
class RequestsResponse {
  final List<Request> items;
  final PagingInfoRequest pagingInfo;

  const RequestsResponse({
    this.pagingInfo =
        const PagingInfoRequest(totalItems: 0, pageSize: 0, page: 1),
    this.items = const [],
  });

  factory RequestsResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestsResponseToJson(this);
}
