import 'package:json_annotation/json_annotation.dart';

part 'approve_requisition_count_status_response.g.dart';

@JsonSerializable()
class ApproveRequisitionCountStatusResponse {
  final int total;
  @JsonKey(name: 'new')
  final int newRequest;
  final int approve;
  final int reject;
  final int edit;
  final int overdueApprove;
  final int cancel;
  final int overdueEdit;

  const ApproveRequisitionCountStatusResponse(
      {required this.total,
      required this.newRequest,
      required this.approve,
      required this.reject,
      required this.edit,
      required this.overdueApprove,
      required this.cancel,
      this.overdueEdit = 0});

  factory ApproveRequisitionCountStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$ApproveRequisitionCountStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequisitionCountStatusResponseToJson(this);
}
