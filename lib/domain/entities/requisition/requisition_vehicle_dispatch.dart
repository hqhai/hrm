import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_vehicle_dispatch.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionVehicleDispatch {
  final String? time;
  final String? startTime;
  final String? endTime;
  final String? drive;
  final String? carCaller;
  final String? schedule;
  final String? reasonForCallingACar;

  const RequisitionVehicleDispatch({
    this.time,
    this.startTime,
    this.endTime,
    this.carCaller,
    this.drive,
    this.reasonForCallingACar,
    this.schedule
    
  });

  factory RequisitionVehicleDispatch.fromJson(Map<String, dynamic> json) =>
      _$RequisitionVehicleDispatchFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionVehicleDispatchToJson(this);
}
