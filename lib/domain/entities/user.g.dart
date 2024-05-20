// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      userName: json['userName'] as String?,
      code: json['code'] as String?,
      tax: json['tax'] as String?,
      attendanceId: json['attendanceId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      dayOfBirth: json['dayOfBirth'] == null
          ? null
          : DateTime.parse(json['dayOfBirth'] as String),
      gender: json['gender'] as String?,
      avatarPath: json['avatarPath'] as String?,
      ciNumber: json['ciNumber'] as String?,
      ciIssuePlace: json['ciIssuePlace'] as String?,
      ciIssueDate: json['ciIssueDate'] == null
          ? null
          : DateTime.parse(json['ciIssueDate'] as String),
      ciExpiryDate: json['ciExpiryDate'] == null
          ? null
          : DateTime.parse(json['ciExpiryDate'] as String),
      passPortNumber: json['passPortNumber'] as String?,
      passPortIssuePlace: json['passPortIssuePlace'] as String?,
      passPortIssueDate: json['passPortIssueDate'] == null
          ? null
          : DateTime.parse(json['passPortIssueDate'] as String),
      passPortExpiryDate: json['passPortExpiryDate'] == null
          ? null
          : DateTime.parse(json['passPortExpiryDate'] as String),
      residentProvince: json['residentProvince'] as String?,
      residentAddress: json['residentAddress'] as String?,
      residentDistrict: json['residentDistrict'] as String?,
      residentWard: json['residentWard'] as String?,
      originAddress: json['originAddress'] as String?,
      originWard: json['originWard'] as String?,
      originDistrict: json['originDistrict'] as String?,
      originProvince: json['originProvince'] as String?,
      residentLocationId: json['residentLocationId'] as String?,
      originLocationId: json['originLocationId'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      ethnicity: json['ethnicity'] as String?,
      religion: json['religion'] as String?,
      bankName: json['bankName'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      families: (json['families'] as List<dynamic>?)
          ?.map((e) => Family.fromJson(e as Map<String, dynamic>))
          .toList(),
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      companyEmail: json['companyEmail'] as String?,
      level: json['level'] as String?,
      education: json['education'] as String?,
      specializes: json['specializes'] as String?,
      graduationType: json['graduationType'] as String?,
      graduationYear: json['graduationYear'] as String?,
      profileStatus: json['profileStatus'] as bool?,
      probationDay: json['probationDay'] == null
          ? null
          : DateTime.parse(json['probationDay'] as String),
      officialDay: json['officialDay'] == null
          ? null
          : DateTime.parse(json['officialDay'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      statusUser: json['statusUser'] as String?,
      typeOfPersonnel: json['typeOfPersonnel'] as String?,
      description: json['description'] as String?,
      userDepartmentPositions:
          (json['userDepartmentPositions'] as List<dynamic>?)
              ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
              .toList(),
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String?,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdUserId': instance.createdUserId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedUserId', instance.updatedUserId);
  writeNotNull('createdFullName', instance.createdFullName);
  writeNotNull('updatedFullName', instance.updatedFullName);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('updatedDate', instance.updatedDate?.toIso8601String());
  writeNotNull('userName', instance.userName);
  writeNotNull('code', instance.code);
  writeNotNull('tax', instance.tax);
  writeNotNull('attendanceId', instance.attendanceId);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('fullName', instance.fullName);
  writeNotNull('dayOfBirth', instance.dayOfBirth?.toIso8601String());
  writeNotNull('gender', instance.gender);
  writeNotNull('avatarPath', instance.avatarPath);
  writeNotNull('ciNumber', instance.ciNumber);
  writeNotNull('ciIssuePlace', instance.ciIssuePlace);
  writeNotNull('ciIssueDate', instance.ciIssueDate?.toIso8601String());
  writeNotNull('ciExpiryDate', instance.ciExpiryDate?.toIso8601String());
  writeNotNull('passPortNumber', instance.passPortNumber);
  writeNotNull('passPortIssuePlace', instance.passPortIssuePlace);
  writeNotNull(
      'passPortIssueDate', instance.passPortIssueDate?.toIso8601String());
  writeNotNull(
      'passPortExpiryDate', instance.passPortExpiryDate?.toIso8601String());
  writeNotNull('residentProvince', instance.residentProvince);
  writeNotNull('residentAddress', instance.residentAddress);
  writeNotNull('residentDistrict', instance.residentDistrict);
  writeNotNull('residentWard', instance.residentWard);
  writeNotNull('originAddress', instance.originAddress);
  writeNotNull('originWard', instance.originWard);
  writeNotNull('originDistrict', instance.originDistrict);
  writeNotNull('originProvince', instance.originProvince);
  writeNotNull('residentLocationId', instance.residentLocationId);
  writeNotNull('originLocationId', instance.originLocationId);
  writeNotNull('maritalStatus', instance.maritalStatus);
  writeNotNull('ethnicity', instance.ethnicity);
  writeNotNull('religion', instance.religion);
  writeNotNull('bankName', instance.bankName);
  writeNotNull('accountHolderName', instance.accountHolderName);
  writeNotNull('accountNumber', instance.accountNumber);
  writeNotNull('families', instance.families);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('email', instance.email);
  writeNotNull('companyEmail', instance.companyEmail);
  writeNotNull('level', instance.level);
  writeNotNull('education', instance.education);
  writeNotNull('specializes', instance.specializes);
  writeNotNull('graduationType', instance.graduationType);
  writeNotNull('graduationYear', instance.graduationYear);
  writeNotNull('profileStatus', instance.profileStatus);
  writeNotNull('probationDay', instance.probationDay?.toIso8601String());
  writeNotNull('officialDay', instance.officialDay?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('statusUser', instance.statusUser);
  writeNotNull('typeOfPersonnel', instance.typeOfPersonnel);
  writeNotNull('description', instance.description);
  writeNotNull('userDepartmentPositions', instance.userDepartmentPositions);
  return val;
}
