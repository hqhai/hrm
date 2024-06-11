import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_releaseds.g.dart';

@CopyWith()
@JsonSerializable()
class WarehouseReleaseds {
  final String? product;
  final RequestWarehouseReleasedsUnitTypeEnum? unit;
  final String? explain;
  final String? note;
  final int? quantity;

  const WarehouseReleaseds({
    this.product,
    this.unit,
    this.note,
    this.explain,
    this.quantity
  });

  factory WarehouseReleaseds.fromJson(Map<String, dynamic> json) =>
      _$WarehouseReleasedsFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseReleasedsToJson(this);
}