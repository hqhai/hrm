import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bussiness_response.g.dart';

@CopyWith()
@JsonSerializable()
class BussinessResponse {
  final String? startDate;
  final String? endDate;
  final int? total;
  final String? content;
  final List<String>? subtitudePersons;
  final String? vehicle;
  final String? destination;
  final String? description;

  const BussinessResponse({
    this.startDate,
    this.endDate,
    this.total,
    this.content,
    this.vehicle,
    this.destination,
    this.description,
    this.subtitudePersons,
  });

  factory BussinessResponse.fromJson(Map<String, dynamic> json) => _$BussinessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BussinessResponseToJson(this);
}
