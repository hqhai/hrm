import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_dialog_model.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class FilterDialogModel {
  final String? flowId;
  final RequisitionTypeEnum? type;
  final Department? department;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? flowName;
  final String? departmentName;
  final List<StatusRequestEnum>? statuses;

  const FilterDialogModel({
    this.departmentName,
    this.flowId,
    this.flowName,
    this.type,
    this.startTime,
    this.endTime,
    this.statuses,
    this.department
  });

  factory FilterDialogModel.fromJson(Map<String, dynamic> json) => _$FilterDialogModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDialogModelToJson(this);

}
