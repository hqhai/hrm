import 'package:base_app/domain/entities/family.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@CopyWith()
@JsonSerializable()
class UpdateProfileRequest {
  final String? id;
  final String? tax;
  final String? firstName;
  final String? lastName;
  final String? dayOfBirth;
  final String? gender;
  final String? avatarPath;
  final String? ciNumber;
  final String? ciIssuePlace;
  final String? ciIssueDate;
  final String? ciExpiryDate;
  final String? passPortNumber;
  final String? passPortIssuePlace;
  final String? passPortIssueDate;
  final String? passPortExpiryDate;
  final String? residentProvince;
  final String? residentAddress;
  final String? residentDistrict;
  final String? residentWard;
  final String? originAddress;
  final String? originWard;
  final String? originDistrict;
  final String? originProvince;
  final String? maritalStatus;
  final String? ethnicity;
  final String? religion;
  final List<Family>? families;
  final String? phoneNumber;
  final String? educationLevel;
  final String? education;
  final String? specializes;
  final String? graduationType;
  final String? graduationYear;
  final String? description;

  const UpdateProfileRequest({
    this.id,
    this.tax,
    this.firstName,
    this.lastName,
    this.dayOfBirth,
    this.gender,
    this.avatarPath,
    this.ciNumber,
    this.ciIssuePlace,
    this.ciIssueDate,
    this.ciExpiryDate,
    this.passPortNumber,
    this.passPortIssuePlace,
    this.passPortIssueDate,
    this.passPortExpiryDate,
    this.residentProvince,
    this.residentAddress,
    this.residentDistrict,
    this.residentWard,
    this.originAddress,
    this.originWard,
    this.originDistrict,
    this.originProvince,
    this.maritalStatus,
    this.ethnicity,
    this.religion,
    this.families,
    this.phoneNumber,
    this.educationLevel,
    this.education,
    this.specializes,
    this.graduationType,
    this.graduationYear,
    this.description,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
