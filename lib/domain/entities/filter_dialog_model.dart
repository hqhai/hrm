import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_dialog_model.g.dart';

@CopyWith()
@JsonSerializable()
class FilterDialogModel {
  final RequisitionTypeEnum type;
  final String startTime;
  final String endTime;
  final List<StatusRequisitionEnum> statuses;

  const FilterDialogModel({
    this.type = RequisitionTypeEnum.business,
    this.startTime = '',
    this.endTime = '',
    this.statuses = const []
  });

  factory FilterDialogModel.fromJson(Map<String, dynamic> json) => _$FilterDialogModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDialogModelToJson(this);

}
