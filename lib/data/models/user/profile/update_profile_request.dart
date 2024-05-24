import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@CopyWith()
@JsonSerializable()
class UpdateProfileRequest {
  final String id;
  final String firstName;
  final String lastName;
  final String dayOfBirth;
  final String gender;
  final String? phoneNumber;
  final String? avatarPath;
  final String? residentProvince;
  final String? residentProvinceId;
  final String? residentAddress;
  final String? residentDistrict;
  final String? residentDistrictId;
  final String? residentWard;
  final String? residentWardId;

  const UpdateProfileRequest({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dayOfBirth,
    required this.gender,
    this.phoneNumber,
    this.avatarPath,
    this.residentProvince,
    this.residentProvinceId,
    this.residentAddress,
    this.residentDistrict,
    this.residentDistrictId,
    this.residentWard,
    this.residentWardId,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
