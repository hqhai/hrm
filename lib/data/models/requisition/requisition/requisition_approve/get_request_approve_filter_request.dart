import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_request_approve_filter_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class GetRequestApproveFilterRequest {
  final int? page;
  final List<String>? flowIds;
  final List<RequisitionTypeEnum>? types;
  final String? createdCode;
  final String? createdDepartmentId;
  final DateTime? startDate;
  final DateTime? endDate;
  final EnumStepRequestStatusEnum? statusApprove;

  const GetRequestApproveFilterRequest({
    this.types,
    this.page,
    this.endDate,
    this.statusApprove,
    this.flowIds,
    this.createdDepartmentId,
    this.startDate,
    this.createdCode,
  });

  factory GetRequestApproveFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRequestApproveFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetRequestApproveFilterRequestToJson(this);
}
