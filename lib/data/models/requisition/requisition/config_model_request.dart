import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_model_request.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class ConfigModelRequest {
  final String? description;
  final String? flowId;
  final EnumReasonLeave? takeLeaveReason;
  final double? numberValue;
  final EditTimekeeping? editTimekeeping;
  final List<String>? substitutesPersons;
  final List<String>? attachments;
  final String? content;
  final String? vehicle;
  final String? destination;
  final String? deliveryType;
  final List<WarehouseReleaseds>? warehourseReleaseds;
  final List<Stationeries>? stationeries;
  final double? subtotal;
  final double? totalAmount;
  final EditTimekeeping? explanationReason;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? total;
  final List<RequisitionOverTime>? overTimes;
  final EnumTakeLeaveType? takeLeaveType;
  final EnumReasonLeave? reasonLeave;
  final EnumSocialInsuranceLeave? socialInsuranceLeave;
  final List<WorkShiftRegisteredDetail>? workShiftSettings;
  final List<Explanation>? explanations;
  final EnumReason? reason;
  final int? startTime;
  final int? endTime;

  const ConfigModelRequest(
      {this.editTimekeeping,
      this.overTimes,
      this.flowId,
      this.description,
      this.attachments,
      this.stationeries,
      this.totalAmount,
      this.subtotal,
      this.numberValue,
      this.deliveryType,
      this.substitutesPersons,
      this.destination,
      this.vehicle,
      this.content,
      this.endDate,
      this.startDate,
      this.explanationReason,
      this.takeLeaveReason,
      this.total,
      this.warehourseReleaseds,
      this.socialInsuranceLeave,
      this.reasonLeave,
      this.takeLeaveType,
      this.workShiftSettings,
      this.explanations,
      this.reason,
      this.endTime,
      this.startTime});

  factory ConfigModelRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfigModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigModelRequestToJson(this);
}
