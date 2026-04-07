import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stationeries.g.dart';

@CopyWith()
@JsonSerializable()
class Stationeries {
  final String? product;
  final String? note;
  final String? unit;
  final int? quantity;
  final double? unitPrice;
  final double? amount;


  const Stationeries({
    this.product,
    this.unit,
    this.note,
    this.quantity,
    this.unitPrice,
    this.amount
  });

  factory Stationeries.fromJson(Map<String, dynamic> json) =>
      _$StationeriesFromJson(json);

  Map<String, dynamic> toJson() => _$StationeriesToJson(this);
}
