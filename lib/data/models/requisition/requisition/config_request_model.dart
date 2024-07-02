import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_request_model.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class ConfigRequestModel {
  final String? description;
  final String? flowId;
  final EnumTakeLeave? takeLeaveReason;
  final double? numberValue;
  final EditTimekeeping? editTimekeeping;
  final List<String>? subtitudePersons;
  final List<String>? attachments;
  final String? content;
  final String? vehicle;
  final String? destination;
  final String? deliveryType;
  final List<WarehouseReleaseds>? warehourseReleaseds;
  final List<Stationeries>? stationeries;
  final double? subtotal;
  final double? totalAmount;
  final String? explanationReason;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? total;
  final List<RequisitionOverTime>? overTimes;

  const ConfigRequestModel({
    this.editTimekeeping,
    this.overTimes,
    this.flowId,
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
    this.takeLeaveReason,
    this.total,
    this.warehourseReleaseds,
  });

  factory ConfigRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigRequestModelToJson(this);
}
