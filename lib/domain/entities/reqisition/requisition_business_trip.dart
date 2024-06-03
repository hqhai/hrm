import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_business_trip.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionBusinessTrip {
  final String? startTime;
  final String? endTime;
  final int? numberDays;
  final String? accompanyingPerson;
  final String? vehicle;
  final String? destination;
  final String? content;

  const RequisitionBusinessTrip({
    this.startTime,
    this.endTime,
    this.numberDays,
    this.accompanyingPerson,
    this.destination,
    this.vehicle,
    this.content,
  });

  factory RequisitionBusinessTrip.fromJson(Map<String, dynamic> json) =>
      _$RequisitionBusinessTripFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionBusinessTripToJson(this);
}
