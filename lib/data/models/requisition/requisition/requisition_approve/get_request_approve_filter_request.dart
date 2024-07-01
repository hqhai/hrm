import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_request_approve_filter_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetRequestApproveFilterRequest {
  final int? page;
  final String? type;
  final String? createdDepartmentId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? statusApprove;



  const GetRequestApproveFilterRequest({
    this.page,
    this.endDate,
    this.statusApprove,
    this.type,
    this.createdDepartmentId,
    this.startDate,
  });

  factory GetRequestApproveFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestApproveFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestApproveFilterRequestToJson(this);
}
