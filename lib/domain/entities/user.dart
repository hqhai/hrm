import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/domain/entities/family.dart';
import 'package:base_app/domain/entities/user_department_position.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final bool isUseLogin;
  final String userName;
  final String code;
  final String tax;
  final int attendanceId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String dayOfBirth;
  final GenderEnum gender;
  final String avatarPath;
  final String ciNumber;
  final String ciIssuePlace;
  final String ciIssueDate;
  final String ciExpiryDate;
  final String passPortNumber;
  final String passPortIssuePlace;
  final String passPortIssueDate;
  final String passPortExpiryDate;
  final String residentProvince;
  final String residentProvinceId;
  final String residentAddress;
  final String residentDistrict;
  final String residentDistrictId;
  final String residentWard;
  final String residentWardId;
  final String originAddress;
  final String originWard;
  final String originWardId;
  final String originDistrict;
  final String originDistrictId;
  final String originProvince;
  final String originProvinceId;
  final String maritalStatus;
  final String ethnicity;
  final String religion;
  final String bankName;
  final String accountHolderName;
  final String accountNumber;
  final List<Family> families;
  final String phoneNumber;
  final String email;
  final String companyEmail;
  final EducationLevelEnum educationLevel;
  final String education;
  final String specializes;
  final String graduationType;
  final String graduationYear;
  final bool profileStatus;
  final String probationDay;
  final String officialDay;
  final String endDate;
  final WorkingStatusEnum workingStatus;
  final String typeOfPersonnel;
  final String description;
  final List<UserDepartmentPosition> userDepartmentPositions;
  final bool isActive;
  final String id;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final String createdDate;
  final String updatedDate;
  final String emergencyName;
  final String emergencyPhoneNumber;
  final String emergencyAddress;
  final VehicleTypeEnum vehicleType;
  final String licensePlate;
  final String autoMaker;

  const User(
      {this.isUseLogin = true,
      this.userName = '',
      this.code = '',
      this.tax = '',
      this.attendanceId = 0,
      this.firstName = '',
      this.lastName = '',
      this.fullName = '',
      this.dayOfBirth = '',
      required this.gender,
      this.avatarPath = '',
      this.ciNumber = '',
      this.ciIssuePlace = '',
      this.ciIssueDate = '',
      this.ciExpiryDate = '',
      this.passPortNumber = '',
      this.passPortIssuePlace = '',
      this.passPortIssueDate = '',
      this.passPortExpiryDate = '',
      this.residentProvince = '',
      this.residentProvinceId = '',
      this.residentAddress = '',
      this.residentDistrict = '',
      this.residentDistrictId = '',
      this.residentWard = '',
      this.residentWardId = '',
      this.originAddress = '',
      this.originWard = '',
      this.originWardId = '',
      this.originDistrict = '',
      this.originDistrictId = '',
      this.originProvince = '',
      this.originProvinceId = '',
      this.maritalStatus = '',
      this.ethnicity = '',
      this.religion = '',
      this.bankName = '',
      this.accountHolderName = '',
      this.accountNumber = '',
      this.families = const [],
      this.phoneNumber = '',
      this.email = '',
      this.companyEmail = '',
      this.educationLevel = EducationLevelEnum.other,
      this.education = '',
      this.specializes = '',
      this.graduationType = '',
      this.graduationYear = '',
      this.profileStatus = true,
      this.probationDay = '',
      this.officialDay = '',
      this.endDate = '',
      this.workingStatus = WorkingStatusEnum.longTermUnpaidLeave,
      this.typeOfPersonnel = '',
      this.description = '',
      this.userDepartmentPositions = const [],
      this.isActive = true,
      required this.id,
      required this.createdUserId,
      this.updatedUserId = '',
      this.createdFullName = '',
      this.updatedFullName = '',
      this.createdDate = '',
      this.updatedDate = '',
      this.emergencyAddress = '',
      this.emergencyName = '',
      this.emergencyPhoneNumber = '',
      this.autoMaker = '',
      this.licensePlate = '',
      this.vehicleType = VehicleTypeEnum.car});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [
        isUseLogin,
        userName,
        code,
        tax,
        attendanceId,
        firstName,
        lastName,
        fullName,
        dayOfBirth,
        gender,
        avatarPath,
        ciNumber,
        ciIssuePlace,
        ciIssueDate,
        ciExpiryDate,
        passPortNumber,
        passPortIssuePlace,
        passPortIssueDate,
        passPortExpiryDate,
        residentProvince,
        residentProvinceId,
        residentAddress,
        residentDistrict,
        residentDistrictId,
        residentWard,
        residentWardId,
        originAddress,
        originWard,
        originWardId,
        originDistrict,
        originDistrictId,
        originProvince,
        originProvinceId,
        maritalStatus,
        ethnicity,
        religion,
        bankName,
        accountHolderName,
        accountNumber,
        families,
        phoneNumber,
        email,
        companyEmail,
        educationLevel,
        education,
        specializes,
        graduationType,
        graduationYear,
        profileStatus,
        probationDay,
        officialDay,
        endDate,
        workingStatus,
        typeOfPersonnel,
        description,
        userDepartmentPositions,
        isActive,
        id,
        createdUserId,
        updatedUserId,
        createdFullName,
        updatedFullName,
        createdDate,
        updatedDate,
        emergencyName,
        emergencyPhoneNumber,
        emergencyAddress,
        vehicleType,
        licensePlate,
        autoMaker
      ];
}
