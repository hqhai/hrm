import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/domain/entities/reqisition/step_requests.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@CopyWith()
@JsonSerializable()
class Request {
  final String id;
  final String? createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final String? code;
  final String? flowId;
  final String? description;
  final ConfigRequestModel config;
  final StatusRequestEnum? status;
  final String? createdPositionId;
  final String? createdDepartmentId;
  final List<String>? followerIds;
  final List<StepRequests>? stepRequests;
  final List<String>? attachments;
  final String? createdCode;
  final String? nameCreatedPosition;
  final String? nameCreatedDepartment;

  const Request({
    required this.id,
    this.description,
    this.createdUserId,
    this.updatedUserId,
    this.status,
    this.updatedDate,
    this.updatedFullName,
    this.createdDate,
    this.createdFullName,
    this.code,
    this.config = const ConfigRequestModel(),
    this.createdDepartmentId,
    this.createdPositionId,
    this.flowId,
    this.followerIds,
    this.stepRequests,
    this.attachments,
    this.createdCode,
    this.nameCreatedDepartment,
    this.nameCreatedPosition
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
