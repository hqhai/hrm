import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition.g.dart';

@CopyWith()
@JsonSerializable()
class Requisition {
  final String id;
  final RequisitionTypeEnum type;
  final StatusRequisitionEnum? status;
  final String? position;
  final String? creatorId;
  final String? department;
  final String? follower;
  final String? title;
  final dynamic content;
  final List<String>? filePaths;
  final String? creator;
  final String? createTime;
  final String? deadLine;


  const Requisition({
    required this.id,
    required this.type,
    this.title,
    this.content,
    this.creator,
    this.createTime,
    this.status,
    this.deadLine,
    this.position,
    this.department,
    this.filePaths,
    this.creatorId,
    this.follower
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => _$RequisitionFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionToJson(this);
}
