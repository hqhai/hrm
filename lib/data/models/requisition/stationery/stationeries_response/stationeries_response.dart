import 'package:base_app/data/models/requisition/stationery/stationeries_response/stationeries.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stationeries_response.g.dart';

@CopyWith()
@JsonSerializable()
class StationeriesResponse {
  final int? subtotal;
  final double? numberValue;
  final int? totalAmount;
  final List<Stationeries>? stationeries;

  const StationeriesResponse({
    this.numberValue,
    this.subtotal,
    this.totalAmount,
    this.stationeries
  });

  factory StationeriesResponse.fromJson(Map<String, dynamic> json) =>
      _$StationeriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StationeriesResponseToJson(this);
}
