import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_dialog_model.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class FilterDialogModel {
  final List<FlowRequest>? flows;
  final List<RequisitionTypeEnum>? types;
  final Department? department;
  final DateTime? startTime;
  final DateTime? endTime;
  final User? user;
  final StatusRequestEnum? status;
  final EnumStepRequestStatusEnum? statusApprove;

  const FilterDialogModel({
    this.flows,
    this.types,
    this.startTime,
    this.endTime,
    this.status,
    this.department,
    this.user,
    this.statusApprove
  });

  factory FilterDialogModel.fromJson(Map<String, dynamic> json) => _$FilterDialogModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDialogModelToJson(this);

}
