import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/stationery_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stationery.g.dart';

@CopyWith()
@JsonSerializable()
class Stationery {
  final String? unit;
  final String? product;
  final String? unitPrice;
  final String? id;

  const Stationery({
    this.id,
    this.unitPrice,
    this.product,
    this.unit
  });

  factory Stationery.fromJson(Map<String, dynamic> json) => _$StationeryFromJson(json);

  Map<String, dynamic> toJson() => _$StationeryToJson(this);
}
