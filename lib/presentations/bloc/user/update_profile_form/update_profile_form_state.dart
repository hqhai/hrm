import 'dart:io';

import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_form_state.g.dart';

enum UpdateProfileFormStatus {
  initial,
  validating,
  validationFailed,
  submitting,
  submitSuccess,
  submitFailed,
}

@CopyWith()
class UpdateProfileFormState extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final DateTime dateOfBirth;
  final GenderEnum gender;
  final Address? province;
  final Address? district;
  final Address? ward;
  final File avatarFile;
  final VehicleTypeEnum? vehicleType;
  final bool firstNameMissing;
  final bool lastNameMissing;
  final UpdateProfileFormStatus status;
  final String errorMessage;

  UpdateProfileFormState({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.address = '',
    DateTime? dateOfBirth,
    this.gender = GenderEnum.male,
    this.province,
    this.district,
    this.ward,
    File? avatarFile,
    this.vehicleType,
    this.firstNameMissing = false,
    this.lastNameMissing = false,
    this.status = UpdateProfileFormStatus.initial,
    this.errorMessage = '',
  })  : dateOfBirth = dateOfBirth ?? DateTime(1970, 1, 1),
        avatarFile = avatarFile ?? File('');

  /// Build an initial form state from an existing user.
  factory UpdateProfileFormState.fromUser(User user) {
    return UpdateProfileFormState(
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      address: user.residentAddress,
      dateOfBirth: user.dayOfBirth ?? DateTime.now(),
      gender: user.gender,
      province:
          Address(id: user.residentProvinceId, name: user.residentProvince),
      district:
          Address(id: user.residentDistrictId, name: user.residentDistrict),
      ward: Address(id: user.residentWardId, name: user.residentWard),
    );
  }

  /// Whether the form has the minimum data required for submission.
  bool get isSubmittable =>
      firstName.isNotEmpty && lastName.isNotEmpty && phoneNumber.isNotEmpty;

  bool get isSubmitting => status == UpdateProfileFormStatus.submitting;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        address,
        dateOfBirth,
        gender,
        province,
        district,
        ward,
        avatarFile.path,
        vehicleType,
        firstNameMissing,
        lastNameMissing,
        status,
        errorMessage,
      ];
}
