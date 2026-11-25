import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/domain/models/requisition/config_request_model.dart';
import 'package:base_app/presentations/bloc/requisition/create_leave_form/create_leave_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateLeaveFormCubit extends Cubit<CreateLeaveFormState> {
  CreateLeaveFormCubit() : super(const CreateLeaveFormState());

  /// Reset to a fresh form (used when entering create mode).
  void reset() => emit(const CreateLeaveFormState());

  /// Seed the form when editing an existing requisition.
  void loadFromConfig({
    required ConfigRequestModel config,
    required List<String> followerIds,
  }) {
    final shifts = config.workShiftSettings;
    final number = shifts.isEmpty
        ? 0.0
        : shifts.map((e) => e.workEffort).reduce((a, b) => a + b);
    emit(CreateLeaveFormState(
      description: config.description,
      startTime: config.startDate,
      endTime: config.endDate,
      followers: List.of(followerIds),
      substitutes: List.of(config.subtitudePersons),
      workShifts: List.of(shifts),
      takeLeaveType: config.takeLeaveType,
      socialInsuranceLeave: config.socialInsuranceLeave,
      reason: config.reasonLeave,
      files: config.attachments.map(File.new).toList(),
      numberValue: number,
      isFirstShift: false,
    ));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void filesChanged(List<File> value) {
    emit(state.copyWith(files: value));
  }

  void reasonChanged(EnumReasonLeave? value) {
    emit(state.copyWith(reason: value));
  }

  void leaveTypeChanged(EnumTakeLeaveType value) {
    emit(state.copyWith(
      takeLeaveType: value,
      reason:
          value == EnumTakeLeaveType.compensatoryLeave ? null : state.reason,
    ));
  }

  void socialInsuranceChanged(EnumSocialInsuranceLeave? value) {
    emit(state.copyWith(
      socialInsuranceLeave: value ?? EnumSocialInsuranceLeave.unknown,
    ));
  }

  void startTimeChanged(DateTime value) {
    emit(state.copyWith(startTime: value));
  }

  /// End time changed — caller should follow up by reloading work shifts.
  void endTimeChanged(DateTime value) {
    emit(state.copyWith(
      endTime: value,
      isShiftLoaded: false,
      isFirstShift: false,
      workShifts: const [],
      numberValue: 0,
    ));
  }

  void shiftsLoaded() {
    emit(state.copyWith(isShiftLoaded: true));
  }

  void workShiftsChanged(List<WorkShiftRegisteredDetail> value) {
    final number = value.isEmpty
        ? 0.0
        : value.map((e) => e.workEffort).reduce((a, b) => a + b);
    emit(state.copyWith(workShifts: value, numberValue: number));
  }

  void descriptionErrorChanged(String value) {
    emit(state.copyWith(errorDescription: value));
  }

  /// Validate the form. Returns true if it can be submitted.
  bool validate({required String shiftRequiredMessage}) {
    final hasShifts = state.workShifts.isNotEmpty;
    emit(state.copyWith(errorShift: hasShifts ? '' : shiftRequiredMessage));
    return hasShifts;
  }

  void markSaving() => emit(state.copyWith(isSaving: true));

  void clearSaving() => emit(state.copyWith(isSaving: false));

  void errorDialogChanged(String value) {
    emit(state.copyWith(errorDialog: value));
  }

  /// Whether the chosen reason matches the leave type — must be true to submit.
  bool get isReasonValid {
    switch (state.takeLeaveType) {
      case EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave:
        return state.reason == EnumReasonLeave.yearlyLeave ||
            state.reason == EnumReasonLeave.seniorityLeave;
      case EnumTakeLeaveType.unpaidLeave:
        final r = state.reason;
        return r == EnumReasonLeave.noSalaryLeave ||
            r == EnumReasonLeave.socialInsuranceLeave;
      case EnumTakeLeaveType.compensatoryLeave:
        return true;
      case EnumTakeLeaveType.otherPaidLeave:
        return state.reason == EnumReasonLeave.mourningLeave ||
            state.reason == EnumReasonLeave.weddingLeave;
      default:
        return false;
    }
  }
}
