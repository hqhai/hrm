import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@CopyWith()
@JsonSerializable()
class School {
  final String id;
  final String nameSchool;
  final String addressSchool;
  final double longitude;
  final double latitude;

  const School({
    this.id = '',
    this.nameSchool = '',
    this.addressSchool = '',
    this.longitude = 0,
    this.latitude = 0,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
