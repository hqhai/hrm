import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/warehouse_released/warehouse_released_response/warehouse_releaseds.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_released_response.g.dart';

@CopyWith()
@JsonSerializable()
class RequestStationery {
  final List<WarehouseReleaseds> warehouseReleaseds;

  const RequestStationery({
    required this.warehouseReleaseds
  });

  factory RequestStationery.fromJson(Map<String, dynamic> json) =>
      _$RequestStationeryFromJson(json);

  Map<String, dynamic> toJson() => _$RequestStationeryToJson(this);
}
