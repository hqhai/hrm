import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@CopyWith()
@JsonSerializable()
class Family {
  final String? id;
  final String? relationShip;
  final String? name;
  final String? phoneNumber;
  final String? yearBithDay;
  final String? job;

  const Family({
    this.id,
    this.relationShip,
    this.name,
    this.phoneNumber,
    this.yearBithDay,
    this.job,
  });

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
