import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_release_of_warehouse.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionReleaseOfWarehouse {
  final String? product;
  final String? explain;
  final RequisitionStationeryUnitTypeEnum? unit;
  final int? number;
  final String? note;


  const RequisitionReleaseOfWarehouse({
    this.product,
    this.unit,
    this.number,
    this.note,
    this.explain
  });

  factory RequisitionReleaseOfWarehouse.fromJson(Map<String, dynamic> json) =>
      _$RequisitionReleaseOfWarehouseFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionReleaseOfWarehouseToJson(this);
}
