import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_driver_response.g.dart';

@CopyWith()
@JsonSerializable()
class VehicleDriverResponse {
  final String? startDate;
  final String? endDate;
  final String? content;
  final List<String>? subtitudePersons;
  final String? vehicle;

  const VehicleDriverResponse({
    this.startDate,
    this.endDate,
    this.content,
    this.vehicle,
    this.subtitudePersons,
  });

  factory VehicleDriverResponse.fromJson(Map<String, dynamic> json) => _$VehicleDriverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDriverResponseToJson(this);
}
