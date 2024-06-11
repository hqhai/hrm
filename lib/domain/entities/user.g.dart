// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      isUseLogin: json['isUseLogin'] as bool?,
      userName: json['userName'] as String?,
      code: json['code'] as String?,
      tax: json['tax'] as String?,
      attendanceId: json['attendanceId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      dayOfBirth: json['dayOfBirth'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumEnumMap, json['gender']),
      avatarPath: json['avatarPath'] as String?,
      ciNumber: json['ciNumber'] as String?,
      ciIssuePlace: json['ciIssuePlace'] as String?,
      ciIssueDate: json['ciIssueDate'] as String?,
      ciExpiryDate: json['ciExpiryDate'] as String?,
      passPortNumber: json['passPortNumber'] as String?,
      passPortIssuePlace: json['passPortIssuePlace'] as String?,
      passPortIssueDate: json['passPortIssueDate'] as String?,
      passPortExpiryDate: json['passPortExpiryDate'] as String?,
      residentProvince: json['residentProvince'] as String?,
      residentProvinceId: json['residentProvinceId'] as String?,
      residentAddress: json['residentAddress'] as String?,
      residentDistrict: json['residentDistrict'] as String?,
      residentDistrictId: json['residentDistrictId'] as String?,
      residentWard: json['residentWard'] as String?,
      residentWardId: json['residentWardId'] as String?,
      originAddress: json['originAddress'] as String?,
      originWard: json['originWard'] as String?,
      originWardId: json['originWardId'] as String?,
      originDistrict: json['originDistrict'] as String?,
      originDistrictId: json['originDistrictId'] as String?,
      originProvince: json['originProvince'] as String?,
      originProvinceId: json['originProvinceId'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      ethnicity: json['ethnicity'] as String?,
      religion: json['religion'] as String?,
      bankName: json['bankName'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      families: (json['families'] as List<dynamic>?)
              ?.map((e) => Family.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      companyEmail: json['companyEmail'] as String?,
      educationLevel: $enumDecodeNullable(
          _$EducationLevelEnumEnumMap, json['educationLevel']),
      education: json['education'] as String?,
      specializes: json['specializes'] as String?,
      graduationType: json['graduationType'] as String?,
      graduationYear: json['graduationYear'] as String?,
      profileStatus: json['profileStatus'] as bool?,
      probationDay: json['probationDay'] as String?,
      officialDay: json['officialDay'] as String?,
      endDate: json['endDate'] as String?,
      workingStatus: $enumDecodeNullable(
          _$WorkingStatusEnumEnumMap, json['workingStatus']),
      typeOfPersonnel: json['typeOfPersonnel'] as String?,
      description: json['description'] as String?,
      userDepartmentPositions: (json['userDepartmentPositions']
                  as List<dynamic>?)
              ?.map((e) =>
                  UserDepartmentPosition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isActive: json['isActive'] as bool?,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String?,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      emergencyAddress: json['emergencyAddress'] as String?,
      emergencyName: json['emergencyName'] as String?,
      emergencyPhoneNumber: json['emergencyPhoneNumber'] as String?,
      autoMaker: json['autoMaker'] as String?,
      licensePlate: json['licensePlate'] as String?,
      vehicleType:
          $enumDecodeNullable(_$VehicleTypeEnumEnumMap, json['vehicleType']),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isUseLogin', instance.isUseLogin);
  writeNotNull('userName', instance.userName);
  writeNotNull('code', instance.code);
  writeNotNull('tax', instance.tax);
  writeNotNull('attendanceId', instance.attendanceId);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('dayOfBirth', instance.dayOfBirth);
  writeNotNull('gender', _$GenderEnumEnumMap[instance.gender]);
  writeNotNull('avatarPath', instance.avatarPath);
  writeNotNull('ciNumber', instance.ciNumber);
  writeNotNull('ciIssuePlace', instance.ciIssuePlace);
  writeNotNull('ciIssueDate', instance.ciIssueDate);
  writeNotNull('ciExpiryDate', instance.ciExpiryDate);
  writeNotNull('passPortNumber', instance.passPortNumber);
  writeNotNull('passPortIssuePlace', instance.passPortIssuePlace);
  writeNotNull('passPortIssueDate', instance.passPortIssueDate);
  writeNotNull('passPortExpiryDate', instance.passPortExpiryDate);
  writeNotNull('residentProvince', instance.residentProvince);
  writeNotNull('residentProvinceId', instance.residentProvinceId);
  writeNotNull('residentAddress', instance.residentAddress);
  writeNotNull('residentDistrict', instance.residentDistrict);
  writeNotNull('residentDistrictId', instance.residentDistrictId);
  writeNotNull('residentWard', instance.residentWard);
  writeNotNull('residentWardId', instance.residentWardId);
  writeNotNull('originAddress', instance.originAddress);
  writeNotNull('originWard', instance.originWard);
  writeNotNull('originWardId', instance.originWardId);
  writeNotNull('originDistrict', instance.originDistrict);
  writeNotNull('originDistrictId', instance.originDistrictId);
  writeNotNull('originProvince', instance.originProvince);
  writeNotNull('originProvinceId', instance.originProvinceId);
  writeNotNull('maritalStatus', instance.maritalStatus);
  writeNotNull('ethnicity', instance.ethnicity);
  writeNotNull('religion', instance.religion);
  writeNotNull('bankName', instance.bankName);
  writeNotNull('accountHolderName', instance.accountHolderName);
  writeNotNull('accountNumber', instance.accountNumber);
  val['families'] = instance.families;
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('email', instance.email);
  writeNotNull('companyEmail', instance.companyEmail);
  writeNotNull(
      'educationLevel', _$EducationLevelEnumEnumMap[instance.educationLevel]);
  writeNotNull('education', instance.education);
  writeNotNull('specializes', instance.specializes);
  writeNotNull('graduationType', instance.graduationType);
  writeNotNull('graduationYear', instance.graduationYear);
  writeNotNull('profileStatus', instance.profileStatus);
  writeNotNull('probationDay', instance.probationDay);
  writeNotNull('officialDay', instance.officialDay);
  writeNotNull('endDate', instance.endDate);
  writeNotNull(
      'workingStatus', _$WorkingStatusEnumEnumMap[instance.workingStatus]);
  writeNotNull('typeOfPersonnel', instance.typeOfPersonnel);
  writeNotNull('description', instance.description);
  val['userDepartmentPositions'] = instance.userDepartmentPositions;
  writeNotNull('isActive', instance.isActive);
  val['id'] = instance.id;
  val['createdUserId'] = instance.createdUserId;
  writeNotNull('updatedUserId', instance.updatedUserId);
  writeNotNull('createdFullName', instance.createdFullName);
  writeNotNull('updatedFullName', instance.updatedFullName);
  writeNotNull('createdDate', instance.createdDate);
  writeNotNull('updatedDate', instance.updatedDate);
  writeNotNull('emergencyName', instance.emergencyName);
  writeNotNull('emergencyPhoneNumber', instance.emergencyPhoneNumber);
  writeNotNull('emergencyAddress', instance.emergencyAddress);
  writeNotNull('vehicleType', _$VehicleTypeEnumEnumMap[instance.vehicleType]);
  writeNotNull('licensePlate', instance.licensePlate);
  writeNotNull('autoMaker', instance.autoMaker);
  return val;
}

const _$GenderEnumEnumMap = {
  GenderEnum.male: 'Male',
  GenderEnum.female: 'Female',
  GenderEnum.other: 'Other',
};

const _$EducationLevelEnumEnumMap = {
  EducationLevelEnum.primarySchool: 'PrimarySchool',
  EducationLevelEnum.secondarySchool: 'SecondarySchool',
  EducationLevelEnum.highSchool: 'HighSchool',
  EducationLevelEnum.vocationalSchool: 'VocationalSchool',
  EducationLevelEnum.college: 'College',
  EducationLevelEnum.university: 'University',
  EducationLevelEnum.masterDegree: 'MasterDegree',
  EducationLevelEnum.doctorate: 'Doctorate',
  EducationLevelEnum.other: 'Other',
};

const _$WorkingStatusEnumEnumMap = {
  WorkingStatusEnum.working: 'Working',
  WorkingStatusEnum.resignation: 'Resignation',
  WorkingStatusEnum.maternityLeave: 'MaternityLeave',
  WorkingStatusEnum.aboutToStart: 'AboutToStart',
  WorkingStatusEnum.longTermUnpaidLeave: 'LongTermUnpaidLeave',
};

const _$VehicleTypeEnumEnumMap = {
  VehicleTypeEnum.car: 'Car',
  VehicleTypeEnum.bike: 'Bike',
  VehicleTypeEnum.motorbike: 'Motorbike',
  VehicleTypeEnum.tram: 'Tram',
};
