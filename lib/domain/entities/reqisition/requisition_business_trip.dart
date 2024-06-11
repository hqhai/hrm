import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requisition_business_trip.g.dart';

@CopyWith()
@JsonSerializable()
class RequisitionBusinessTrip {
  final String? startDate;
  final String? endDate;
  final int? totalTime;
  final String? content;
  final List<String>? substitutePersons;
  final String? vehicle;

  const RequisitionBusinessTrip({
    this.startDate,
    this.endDate,
    this.totalTime,
    this.substitutePersons,
    this.vehicle,
    this.content,
  });

  factory RequisitionBusinessTrip.fromJson(Map<String, dynamic> json) =>
      _$RequisitionBusinessTripFromJson(json);

  Map<String, dynamic> toJson() => _$RequisitionBusinessTripToJson(this);
}
