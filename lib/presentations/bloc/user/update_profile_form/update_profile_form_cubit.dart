import 'dart:io';

import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/presentations/bloc/user/update_profile_form/update_profile_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfileFormCubit extends Cubit<UpdateProfileFormState> {
  UpdateProfileFormCubit() : super(UpdateProfileFormState());

  /// Re-initialize the form from the latest user. Call this when the page
  /// opens so the form draft starts with the user's current values.
  void loadFromUser(User user) {
    emit(UpdateProfileFormState.fromUser(user));
  }

  void firstNameChanged(String value) {
    emit(state.copyWith(firstName: value, firstNameMissing: false));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(lastName: value, lastNameMissing: false));
  }

  void phoneNumberChanged(String value) {
    emit(state.copyWith(phoneNumber: value));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: value));
  }

  void dateOfBirthChanged(DateTime value) {
    emit(state.copyWith(dateOfBirth: value));
  }

  void genderChanged(GenderEnum value) {
    emit(state.copyWith(gender: value));
  }

  void provinceChanged(Address? value) {
    // Changing province invalidates the dependent district/ward.
    emit(state.copyWith(province: value, district: null, ward: null));
  }

  void districtChanged(Address? value) {
    emit(state.copyWith(district: value, ward: null));
  }

  void wardChanged(Address? value) {
    emit(state.copyWith(ward: value));
  }

  void avatarChanged(File value) {
    emit(state.copyWith(avatarFile: value));
  }

  void vehicleTypeChanged(VehicleTypeEnum? value) {
    emit(state.copyWith(vehicleType: value));
  }

  /// Validate the form. Returns true if it can be submitted.
  bool validate() {
    final firstNameMissing = state.firstName.isEmpty;
    final lastNameMissing = state.lastName.isEmpty;
    emit(state.copyWith(
      firstNameMissing: firstNameMissing,
      lastNameMissing: lastNameMissing,
      status: (firstNameMissing || lastNameMissing)
          ? UpdateProfileFormStatus.validationFailed
          : UpdateProfileFormStatus.validating,
    ));
    return !firstNameMissing && !lastNameMissing && state.isSubmittable;
  }

  void markSubmitting() {
    emit(state.copyWith(status: UpdateProfileFormStatus.submitting));
  }

  void markSubmitSuccess() {
    emit(state.copyWith(status: UpdateProfileFormStatus.submitSuccess));
  }

  void markSubmitFailed(String message) {
    emit(state.copyWith(
      status: UpdateProfileFormStatus.submitFailed,
      errorMessage: message,
    ));
  }
}
