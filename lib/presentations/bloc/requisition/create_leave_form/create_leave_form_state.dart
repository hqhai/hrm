import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'create_leave_form_state.g.dart';

@CopyWith()
class CreateLeaveFormState extends Equatable {
  final String description;
  final DateTime? startTime;
  final DateTime? endTime;
  final double numberValue;
  final List<File> files;
  final List<String> followers;
  final List<String> substitutes;
  final List<WorkShiftRegisteredDetail> workShifts;
  final EnumTakeLeaveType takeLeaveType;
  final EnumSocialInsuranceLeave socialInsuranceLeave;
  final EnumReasonLeave? reason;
  final bool isShiftLoaded;
  final bool isFirstShift;
  final bool isSaving;
  final String errorShift;
  final String errorDescription;
  final String errorDialog;

  const CreateLeaveFormState({
    this.description = '',
    this.startTime,
    this.endTime,
    this.numberValue = 0,
    this.files = const [],
    this.followers = const [],
    this.substitutes = const [],
    this.workShifts = const [],
    this.takeLeaveType = EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave,
    this.socialInsuranceLeave = EnumSocialInsuranceLeave.unknown,
    this.reason,
    this.isShiftLoaded = true,
    this.isFirstShift = true,
    this.isSaving = false,
    this.errorShift = '',
    this.errorDescription = '',
    this.errorDialog = '',
  });

  @override
  List<Object?> get props => [
        description,
        startTime,
        endTime,
        numberValue,
        files,
        followers,
        substitutes,
        workShifts,
        takeLeaveType,
        socialInsuranceLeave,
        reason,
        isShiftLoaded,
        isFirstShift,
        isSaving,
        errorShift,
        errorDescription,
        errorDialog,
      ];
}
