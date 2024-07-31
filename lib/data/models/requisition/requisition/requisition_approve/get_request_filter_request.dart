import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_request_filter_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetRequestFilterRequest {
  final int? page;
  final List<String>? listFlowIds;
  final List<RequisitionTypeEnum>? type;
  final String? userId;
  final String? departmentIds;
  final DateTime? startDate;
  final DateTime? endDate;
  final StatusRequestEnum? statuses;

  const GetRequestFilterRequest({
    this.type,
    this.page,
    this.endDate,
    this.statuses,
    this.listFlowIds,
    this.departmentIds,
    this.startDate,
    this.userId,
  });

  factory GetRequestFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestFilterRequestToJson(this);
}
