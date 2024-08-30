import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class School {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String fax;
  final String googleMapLink;
  final String description;
  final String contactName;
  final String contactEmail;
  final String contactPhoneNumber;
  final int minDistance;
  final String address;
  final double longitude;
  final double latitude;

  const School({
    this.id = '',
    this.name = '',
    this.address = '',
    this.longitude = 0,
    this.latitude = 0,
    this.description = '',
    this.phoneNumber = '',
    this.fax = '',
    this.email = '',
    this.contactEmail = '',
    this.contactName = '',
    this.contactPhoneNumber = '',
    this.googleMapLink = '',
    this.minDistance = 0,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
