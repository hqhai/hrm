import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_request_filter_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetRequestFilterRequest {
  final int? page;
  final String? flowId;
  final String? type;
  final String? createdDepartmentId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? statuses;

  const GetRequestFilterRequest({
    this.type,
    this.page,
    this.endDate,
    this.statuses,
    this.flowId,
    this.createdDepartmentId,
    this.startDate,
  });

  factory GetRequestFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestFilterRequestToJson(this);
}
