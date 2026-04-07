import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/models/requisition/config_request_model.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/step_requests.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class Request extends Equatable {
  final String id;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final String code;
  final String flowId;
  @JsonKey(unknownEnumValue: RequisitionTypeEnum.unknown)
  final RequisitionTypeEnum flowType;
  final String nameFlow;
  final ConfigRequestModel config;
  @JsonKey(unknownEnumValue: StatusRequestEnum.unknown)
  final StatusRequestEnum status;
  final String createdPositionId;
  final bool isFirstStep;
  final String createdDepartmentId;
  final List<String> followerIds;
  final List<StepRequests> stepRequests;
  final List<String> attachments;
  final String createdCode;
  final String nameCreatedPosition;
  final String nameCreatedDepartment;
  final bool isEdit;
  final FlowRequest? flow;

  const Request({this.id = '', this.createdUserId = '', this.updatedUserId = '', this.flowType = RequisitionTypeEnum.unknown, this.status = StatusRequestEnum.unknown, this.updatedDate, this.updatedFullName = '', this.createdDate, this.createdFullName = '', this.code = '', this.config = const ConfigRequestModel(), this.createdDepartmentId = '', this.createdPositionId = '', this.flowId = '', this.followerIds = const [], this.stepRequests = const [], this.attachments = const [], this.createdCode = '', this.nameCreatedDepartment = '', this.nameCreatedPosition = '', this.nameFlow = '', this.isFirstStep = false, this.isEdit = false, this.flow});

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);

  @override
  List<Object?> get props => [
        id,
        createdUserId,
        updatedUserId,
        createdFullName,
        updatedFullName,
        createdDate,
        updatedDate,
        code,
        flowId,
        config,
        status,
        createdPositionId,
        createdDepartmentId,
        followerIds,
        stepRequests,
        attachments,
        createdCode,
        nameCreatedPosition,
        nameCreatedDepartment,
        isFirstStep,
        isEdit,
        flow,
      ];
}
