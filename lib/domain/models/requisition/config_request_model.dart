import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/date_time_json.dart';
import 'package:base_app/domain/models/requisition/explanation.dart';
import 'package:base_app/domain/models/requisition/stationeries.dart';
import 'package:base_app/domain/models/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'config_request_model.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class ConfigRequestModel {
  final String description;
  final String flowId;
  final EnumReasonLeave takeLeaveReason;
  final double numberValue;
  final EditTimekeeping editTimekeeping;
  final List<String> subtitudePersons;
  final List<String> attachments;
  final String content;
  final String vehicle;
  final String destination;
  final String deliveryType;
  final List<WarehouseReleaseds> warehourseReleaseds;
  final List<Stationeries> stationeries;
  final double subtotal;
  final double totalAmount;
  final EditTimekeeping explanationReason;
  final DateTime? startDate;
  final DateTime? endDate;
  final double total;
  final List<RequisitionOverTime>? overTimes;
  final EnumTakeLeaveType takeLeaveType;
  final EnumReasonLeave reasonLeave;
  final EnumSocialInsuranceLeave socialInsuranceLeave;
  final List<WorkShiftRegisteredDetail> workShiftSettings;
  final List<Explanation> explanations;
  final EnumReason reason;
  final int startTime;
  final int endTime;

  const ConfigRequestModel(
      {this.editTimekeeping = EditTimekeeping.unknown,
      this.overTimes,
      this.flowId = '',
      this.description = '',
      this.attachments = const [],
      this.stationeries = const [],
      this.totalAmount = 0,
      this.subtotal = 0,
      this.numberValue = 0,
      this.deliveryType = '',
      this.subtitudePersons = const [],
      this.destination = '',
      this.vehicle = '',
      this.content = '',
      this.endDate,
      this.startDate,
      this.explanationReason = EditTimekeeping.unknown,
      this.takeLeaveReason = EnumReasonLeave.unknown,
      this.total = 0,
      this.warehourseReleaseds = const [],
      this.socialInsuranceLeave = EnumSocialInsuranceLeave.unknown,
      this.reasonLeave = EnumReasonLeave.unknown,
      this.takeLeaveType = EnumTakeLeaveType.unknown,
      this.workShiftSettings = const [],
      this.explanations = const [],
      this.reason = EnumReason.unknown,
      this.endTime = 0,
      this.startTime = 0});

  factory ConfigRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ConfigRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigRequestModelToJson(this);
}
