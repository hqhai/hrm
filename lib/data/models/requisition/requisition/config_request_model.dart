import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_request_model.g.dart';

@CopyWith()
@JsonSerializable()
class ConfigRequestModel {
  final String? description;
  final String? flowId;
  final String? takeLeaveReason;
  final double? numberValue;
  final List<String>? subtitudePersons;
  final List<String>? attachments;
  final String? content;
  final String? vehicle;
  final String? destination;
  final String? overTimes;
  final String? deliveryType;
  final List<WarehouseReleaseds>? warehourseReleaseds;
  final List<Stationeries>? stationeries;
  final double? subtotal;
  final double? totalAmount;
  final String? explanationReason;
  final String? startDate;
  final String? endDate;
  final double? total;

  const ConfigRequestModel(
      {this.flowId,
      this.description,
      this.attachments,
      this.stationeries,
      this.totalAmount,
      this.subtotal,
      this.numberValue,
      this.deliveryType,
      this.subtitudePersons,
      this.destination,
      this.vehicle,
      this.content,
      this.endDate,
      this.startDate,
      this.explanationReason,
      this.overTimes,
      this.takeLeaveReason,
      this.total,
      this.warehourseReleaseds});

  factory ConfigRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigRequestModelToJson(this);
}
