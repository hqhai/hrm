import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum WorkShiftRequestStatus {
  @JsonValue('Pending')
  pending('Pending'),
  @JsonValue('Approve')
  approve('Approve'),
  @JsonValue('Reject')
  reject('Reject'),
  @JsonValue('PendingCancel')
  pendingCancel('PendingCancel'),
  @JsonValue('Cancel')
  cancel('Cancel'),
  @JsonValue('Remove')
  remove('Remove'),
  @JsonValue('Usable')
  usable('Usable'),
  @JsonValue('Unusable')
  unusable('Unusable');

  final String name;

  const WorkShiftRequestStatus(this.name);
}

extension ConfigWorkShiftRequestStatusExtension on WorkShiftRequestStatus {
  String get configWorkShiftRequestStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case WorkShiftRequestStatus.pending:
        return appLocalizations.pending;
      case WorkShiftRequestStatus.approve:
        return appLocalizations.approver;
      case WorkShiftRequestStatus.reject:
        return appLocalizations.reject;
      case WorkShiftRequestStatus.pendingCancel:
        return appLocalizations.pendingCancel;
      case WorkShiftRequestStatus.cancel:
        return appLocalizations.cancel;
      case WorkShiftRequestStatus.remove:
        return appLocalizations.remove;
      case WorkShiftRequestStatus.usable:
        return appLocalizations.usable;
      case WorkShiftRequestStatus.unusable:
        return appLocalizations.unusable;
    }
  }
}

enum WorkShiftApproveStatus {
  @JsonValue('Pending')
  pending('Pending'),
  @JsonValue('Approve')
  approve('Approve'),
  @JsonValue('Reject')
  reject('Reject'),
  @JsonValue('Remove')
  remove('Remove');

  final String name;

  const WorkShiftApproveStatus(this.name);
}

extension ConfigWorkShiftApproveStatusExtension on WorkShiftApproveStatus {
  String get configWorkShiftApproveStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {

      case WorkShiftApproveStatus.pending:
        return appLocalizations.pending;
      case WorkShiftApproveStatus.approve:
        return appLocalizations.approver;
      case WorkShiftApproveStatus.reject:
        return appLocalizations.reject;
      case WorkShiftApproveStatus.remove:
        return appLocalizations.remove;
    }
  }
}

enum ShiftType {
  @JsonValue('AdministrativeShift')
  administrativeShift('AdministrativeShift'),
  @JsonValue('SingleShift')
  singleShift('SingleShift');

  final String name;

  const ShiftType(this.name);
}

extension ConfigShiftTypeExtension on ShiftType {
  String get configShiftTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case ShiftType.administrativeShift:
        return appLocalizations.remove;
      case ShiftType.singleShift:
        return appLocalizations.remove;
    }
  }
}


