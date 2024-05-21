import 'package:base_app/data/models/user/profile/update_user_department_position_request.dart';
import 'package:base_app/domain/entities/family.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  final String id;
  final String? createdUserId;
  final String? updatedUserId;
  final String? createdFullName;
  final String? updatedFullName;
  final String? createdDate;
  final String? updatedDate;
  final String? userName;
  final String? code;
  final String? tax;
  final int? attendanceId;
  final String firstName;
  final String lastName;
  final String? fullName;
  final String dayOfBirth;
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
  final String? residentLocationId;
  final String? originLocationId;
  final String? maritalStatus;
  final String? ethnicity;
  final String? religion;
  final String? bankName;
  final String? accountHolderName;
  final String? accountNumber;
  final List<Family>? families;
  final String? phoneNumber;
  final String? email;
  final String? companyEmail;
  final String? educationLevel;
  final String? education;
  final String? specializes;
  final String? graduationType;
  final String? graduationYear;
  final bool? profileStatus;
  final String? probationDay;
  final String? officialDay;
  final String? endDate;
  final String? statusUser;
  final String? typeOfPersonnel;
  final String? description;
  final List<UpdateUserDepartmentPositionRequest> userDepartmentPositions;

  const UpdateProfileRequest({
    required this.id,
    this.createdUserId,
    this.updatedUserId,
    this.createdFullName,
    this.updatedFullName,
    this.createdDate,
    this.updatedDate,
    this.userName,
    this.code,
    this.tax,
    this.attendanceId,
    required this.firstName,
    required this.lastName,
    this.fullName,
    required this.dayOfBirth,
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
    this.residentLocationId,
    this.originLocationId,
    this.maritalStatus,
    this.ethnicity,
    this.religion,
    this.bankName,
    this.accountHolderName,
    this.accountNumber,
    this.families,
    this.phoneNumber,
    this.email,
    this.companyEmail,
    this.educationLevel,
    this.education,
    this.specializes,
    this.graduationType,
    this.graduationYear,
    this.profileStatus,
    this.probationDay,
    this.officialDay,
    this.endDate,
    this.statusUser,
    this.typeOfPersonnel,
    this.description,
    required this.userDepartmentPositions,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
