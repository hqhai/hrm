import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_postal_delivery_service.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionPostalDeliveryService {
  final String? content;
  final String? shippingPurpose;

  const RequisitionPostalDeliveryService({
    this.content,
    this.shippingPurpose
  });

  factory RequisitionPostalDeliveryService.fromJson(Map<String, dynamic> json) =>
      _$RequisitionPostalDeliveryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionPostalDeliveryServiceToJson(this);
}
