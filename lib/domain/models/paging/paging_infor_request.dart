import 'package:json_annotation/json_annotation.dart';

part 'paging_infor_request.g.dart';

@JsonSerializable()
class PagingInfoRequest {
  final int pageSize;
  final int page;
  final int totalItems;

  const PagingInfoRequest({
    this.totalItems = 0,
    this.pageSize = 0,
    this.page = 0,
  });

  factory PagingInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PagingInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PagingInfoRequestToJson(this);
}
