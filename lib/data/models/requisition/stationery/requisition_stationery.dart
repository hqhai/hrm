import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_stationery.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionStationery {
  final String? product;
  final RequisitionStationeryUnitTypeEnum? unit;
  final int? unitPrice;
  final int? number;
  final int? money;
  final String? note;

  const RequisitionStationery({
    this.product,
    this.unit,
    this.unitPrice,
    this.number,
    this.money,
    this.note,
  });

  factory RequisitionStationery.fromJson(Map<String, dynamic> json) =>
      _$RequisitionStationeryFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionStationeryToJson(this);
}
