import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_leave_history_model.g.dart';

@CopyWith()
@JsonSerializable()
class FilterLeaveHistoryModel {
  final TypeLeaveEnum? type;
  final DateTime? date;

  const FilterLeaveHistoryModel({
    this.type,
    this.date
  });

  factory FilterLeaveHistoryModel.fromJson(Map<String, dynamic> json) => _$FilterLeaveHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterLeaveHistoryModelToJson(this);

}
