import 'package:base_app/domain/models/paging/paging_infor_request.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow_response.g.dart';

@JsonSerializable()
class FlowResponse {
  final PagingInfoRequest pagingInfo;
  final List<FlowRequest> items;

  const FlowResponse({
    this.items = const [],
    this.pagingInfo =
        const PagingInfoRequest(totalItems: 0, pageSize: 0, page: 1),
  });

  factory FlowResponse.fromJson(Map<String, dynamic> json) =>
      _$FlowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlowResponseToJson(this);
}
