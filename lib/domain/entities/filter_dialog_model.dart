import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'filter_dialog_model.g.dart';

@CopyWith()
@JsonSerializable()
class FilterDialogModel {
  final String type;
  final String startTime;
  final String endTime;
  final List<String> statuses;

  const FilterDialogModel({
    this.type = '',
    this.startTime = '',
    this.endTime = '',
    this.statuses = const []
  });

  factory FilterDialogModel.fromJson(Map<String, dynamic> json) => _$FilterDialogModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDialogModelToJson(this);

}
