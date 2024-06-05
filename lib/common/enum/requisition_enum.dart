import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

enum StatusRequisitionEnum {
  pending('Pending'),
  reject('Reject'),
  modification('Modification application'),
  done('Done'),
  expiredEdit('Expired edit'),
  expired('Expired');

  final String name;

  const StatusRequisitionEnum(this.name);
}

extension ConfigStatusExtension on StatusRequisitionEnum {
  String get configStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case StatusRequisitionEnum.pending:
        return appLocalizations.pending;
      case StatusRequisitionEnum.reject:
        return appLocalizations.reject;
      case StatusRequisitionEnum.modification:
        return appLocalizations.modification;
      case StatusRequisitionEnum.done:
        return appLocalizations.done;
      case StatusRequisitionEnum.expiredEdit:
        return appLocalizations.expiredEdit;
      case StatusRequisitionEnum.expired:
        return appLocalizations.expired;
    }
  }
}

enum RequisitionTypeEnum {
  leave('Application for leave'),
  explanation('Explanation'),
  overtime('Overtime'),
  vehicleDispatch('Application for vehicle dispatch'),
  postalDelivery('Application for postal delivery'),
  releaseOfWarehouse('Application for release of warehouse'),
  stationeryOrder('Stationery order form'),
  business('application for business trip');

  final String name;

  const RequisitionTypeEnum(this.name);
}

extension ConfigTypeExtension on RequisitionTypeEnum {
  String get configTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeEnum.leave:
        return appLocalizations.leave;
      case RequisitionTypeEnum.explanation:
        return appLocalizations.explanation;
      case RequisitionTypeEnum.overtime:
        return appLocalizations.overtime;
      case RequisitionTypeEnum.vehicleDispatch:
        return appLocalizations.vehicleDispatch;
      case RequisitionTypeEnum.postalDelivery:
        return appLocalizations.postalDelivery;
      case RequisitionTypeEnum.releaseOfWarehouse:
        return appLocalizations.releaseOfWarehouse;
      case RequisitionTypeEnum.stationeryOrder:
        return appLocalizations.stationeryOrder;
      case RequisitionTypeEnum.business:
        return appLocalizations.business;
    }
  }
}

enum RequisitionTypeExplanationEnum {
  leaveEarly('LeaveEarly'),
  late('Late'),
  leaveCorrection('Requisition of leave correction'),
  editTimekeeping('Edit timekeeping');

  final String name;

  const RequisitionTypeExplanationEnum(this.name);
}

extension ConfigRequisitionTypeExplanationExtension on RequisitionTypeExplanationEnum {
  String get configRequisitionTypeExplanationName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeExplanationEnum.leaveEarly:
        return appLocalizations.leaveEarly;
      case RequisitionTypeExplanationEnum.late:
        return appLocalizations.late;
      case RequisitionTypeExplanationEnum.leaveCorrection:
        return appLocalizations.leaveCorrection;
      case RequisitionTypeExplanationEnum.editTimekeeping:
        return appLocalizations.editTimekeeping;
    }
  }
}

enum RequisitionTypeOnLeaveEnum {
  annualLeave('Annual leave'),
  compensatoryLeave('Compensatory leave'),
  sickLeave('Sick leave'),
  otherPaidLeave('Other paid leave'),
  leaveWithoutPay('Leave without pay'),
  other('Other');

  final String name;

  const RequisitionTypeOnLeaveEnum(this.name);
}

extension ConfigRequisitionTypeOnLeaveExtension on RequisitionTypeOnLeaveEnum {
  String get configRequisitionTypeOnLeaveName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeOnLeaveEnum.annualLeave:
        return appLocalizations.annualLeave;
      case RequisitionTypeOnLeaveEnum.compensatoryLeave:
        return appLocalizations.compensatoryLeave;
      case RequisitionTypeOnLeaveEnum.sickLeave:
        return appLocalizations.sickLeave;
      case RequisitionTypeOnLeaveEnum.otherPaidLeave:
        return appLocalizations.otherPaidLeave;
      case RequisitionTypeOnLeaveEnum.leaveWithoutPay:
        return appLocalizations.leaveWithoutPay;
      case RequisitionTypeOnLeaveEnum.other:
        return appLocalizations.other;
    }
  }
}

enum RequisitionTransferTypeEnum {
  often('Often'),
  superSpeed('Super speed');

  final String name;

  const RequisitionTransferTypeEnum(this.name);
}

extension ConfigRequisitionTransferTypeExtension on RequisitionTransferTypeEnum {
  String get configRequisitionTransferTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTransferTypeEnum.often:
        return appLocalizations.often;
      case RequisitionTransferTypeEnum.superSpeed:
        return appLocalizations.superSpeed;
    }
  }
}
