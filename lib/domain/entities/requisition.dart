import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition.g.dart';

@CopyWith()
@JsonSerializable()
class Requisition {
  final String id;
  final RequisitionTypeEnum type;
  final String? title;
  final String? content;
  final String? creator;
  final String? createTime;
  final String? deadLine;
  final StatusRequisitionEnum? status;

  const Requisition({
    required this.id,
    required this.type,
    this.title,
    this.content,
    this.creator,
    this.createTime,
    this.status,
    this.deadLine,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => _$RequisitionFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionToJson(this);
}
