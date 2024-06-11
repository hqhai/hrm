import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'postal_delivery_response.g.dart';

@JsonSerializable()
class PotalDeliveryResponse {
  const PotalDeliveryResponse({required this.deliveryType});

  final RequisitionDeliveryTypeEnum deliveryType;

  factory PotalDeliveryResponse.fromJson(Map<String, dynamic> json) =>
      _$PotalDeliveryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PotalDeliveryResponseToJson(this);
}
