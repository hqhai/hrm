import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum EnumTakeLeave {
  @JsonValue('YearlyLeave')
  yearlyLeave('YearlyLeave'),
  @JsonValue('SeniorityLeave')
  seniorityLeave('SeniorityLeave'),
  @JsonValue('CompensatoryLeave')
  compensatoryLeave('CompensatoryLeave'),
  @JsonValue('WeddingLeave')
  weddingLeave('WeddingLeave'),
  @JsonValue('MourningLeave')
  mourningLeave('MourningLeave'),
  @JsonValue('HomeSickLeave')
  homeSickLeave('HomeSickLeave'),
  @JsonValue('HospitalSickLeave')
  hospitalSickLeave('HospitalSickLeave'),
  @JsonValue('MaternityLeave')
  maternityLeave('MaternityLeave');

  final String name;

  const EnumTakeLeave(this.name);
}

extension ConfigEnumTakeLeaveExtension on EnumTakeLeave {
  String get configEnumTakeLeaveName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumTakeLeave.yearlyLeave:
        return appLocalizations.yearlyLeave;
      case EnumTakeLeave.seniorityLeave:
        return appLocalizations.seniorityLeave;
      case EnumTakeLeave.compensatoryLeave:
        return appLocalizations.compensatoryLeave;
      case EnumTakeLeave.weddingLeave:
        return appLocalizations.weddingLeave;
      case EnumTakeLeave.mourningLeave:
        return appLocalizations.mourningLeave;
      case EnumTakeLeave.homeSickLeave:
        return appLocalizations.homeSickLeave;
      case EnumTakeLeave.hospitalSickLeave:
        return appLocalizations.hospitalSickLeave;
      case EnumTakeLeave.maternityLeave:
        return appLocalizations.maternityLeave;
    }
  }
}

enum EnumStepRequestStatusEnum {
  @JsonValue('New')
  newStatus('New'),
  @JsonValue('Approve')
  approve('Approve'),
  @JsonValue('Reject')
  reject('Reject'),
  @JsonValue('Edit')
  edit('Edit'),
  @JsonValue('OverdueApprove')
  overdueApprove('OverdueApprove');

  final String name;

  const EnumStepRequestStatusEnum(this.name);
}

extension ConfigStepRequestStatusExtension on EnumStepRequestStatusEnum {
  String get configStepRequestStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumStepRequestStatusEnum.newStatus:
        return appLocalizations.newStatus;
      case EnumStepRequestStatusEnum.approve:
        return appLocalizations.done;
      case EnumStepRequestStatusEnum.reject:
        return appLocalizations.reject;
      case EnumStepRequestStatusEnum.edit:
        return appLocalizations.edit;
      case EnumStepRequestStatusEnum.overdueApprove:
        return appLocalizations.overdueApprove;
    }
  }
}

enum StatusRequestEnum {
  @JsonValue('Process')
  process('Process'),
  @JsonValue('Reject')
  reject('Reject'),
  @JsonValue('Edit')
  edit('Edit'),
  @JsonValue('Approve')
  approve('Approve'),
  @JsonValue('Cancel')
  cancel('Cancel'),
  @JsonValue('OverdueEdit')
  overdueEdit('OverdueEdit'),
  @JsonValue('OverdueApprove')
  overdueApprove('OverdueApprove');

  final String name;

  const StatusRequestEnum(this.name);
}

extension ConfigRequestStatusExtension on StatusRequestEnum {
  String get configRequestStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case StatusRequestEnum.process:
        return appLocalizations.process;
      case StatusRequestEnum.reject:
        return appLocalizations.reject;
      case StatusRequestEnum.edit:
        return appLocalizations.edit;
      case StatusRequestEnum.approve:
        return appLocalizations.done;
      case StatusRequestEnum.cancel:
        return appLocalizations.cancel;
      case StatusRequestEnum.overdueEdit:
        return appLocalizations.overdueEdit;
      case StatusRequestEnum.overdueApprove:
        return appLocalizations.overdueApprove;
    }
  }
}

enum EnumStepFlowType {
  @JsonValue('Start')
  start('Start'),
  @JsonValue('Step')
  step('Step'),
  @JsonValue('End')
  end('End');

  final String name;

  const EnumStepFlowType(this.name);
}

extension ConfigStepFlowTypeExtension on EnumStepFlowType {
  String get configStepFlowTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumStepFlowType.start:
        return appLocalizations.start;
      case EnumStepFlowType.step:
        return appLocalizations.step;
      case EnumStepFlowType.end:
        return appLocalizations.end;
    }
  }
}

enum RequisitionTypeEnum {
  @JsonValue('Core')
  core('Core'),
  @JsonValue('YearlyAndSeniorityLeave')
  yearlyAndSeniorityLeave('YearlyAndSeniorityLeave'),
  @JsonValue('CompensatoryLeave')
  compensatoryLeave('CompensatoryLeave'),
  @JsonValue('OtherLeave')
  otherLeave('OtherLeave'),
  @JsonValue('UnpaidLeave')
  unpaidLeave('UnpaidLeave'),
  @JsonValue('LateArrival')
  lateArrival('LateArrival'),
  @JsonValue('EarlyDeparture')
  earlyDeparture('EarlyDeparture'),
  @JsonValue('Bussiness')
  bussiness('Bussiness'),
  @JsonValue('OverTime')
  overTime('OverTime'),
  @JsonValue('VehicleDriver')
  vehicleDriver('VehicleDriver'),
  @JsonValue('PostalDelivery')
  postalDelivery('PostalDelivery'),
  @JsonValue('WarehouseReleased')
  warehouseReleased('WarehouseReleased'),
  @JsonValue('Stationery')
  stationery('Stationery'),
  @JsonValue('Explanation')
  explanation('Explanation');

  final String name;

  const RequisitionTypeEnum(this.name);
}

extension ConfigTypeExtension on RequisitionTypeEnum {
  String get configTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeEnum.yearlyAndSeniorityLeave:
        return appLocalizations.yearlyAndSeniorityLeave;
      case RequisitionTypeEnum.explanation:
        return appLocalizations.explanation;
      case RequisitionTypeEnum.overTime:
        return appLocalizations.overtime;
      case RequisitionTypeEnum.vehicleDriver:
        return appLocalizations.vehicleDispatch;
      case RequisitionTypeEnum.postalDelivery:
        return appLocalizations.postalDelivery;
      case RequisitionTypeEnum.warehouseReleased:
        return appLocalizations.releaseOfWarehouse;
      case RequisitionTypeEnum.stationery:
        return appLocalizations.stationeryOrder;
      case RequisitionTypeEnum.bussiness:
        return appLocalizations.business;
      case RequisitionTypeEnum.compensatoryLeave:
        return appLocalizations.compensatoryLeave;
      case RequisitionTypeEnum.otherLeave:
        return appLocalizations.otherLeave;
      case RequisitionTypeEnum.unpaidLeave:
        return appLocalizations.unpaidLeave;
      case RequisitionTypeEnum.lateArrival:
        return appLocalizations.late;
      case RequisitionTypeEnum.earlyDeparture:
        return appLocalizations.leaveEarly;
      case RequisitionTypeEnum.core:
    return appLocalizations.core;
    }
  }
}

enum RequisitionTypeExplanationEnum {
  early('Early'),
  late('Late'),
  other('Other');

  final String name;

  const RequisitionTypeExplanationEnum(this.name);
}

extension ConfigRequisitionTypeExplanationExtension on RequisitionTypeExplanationEnum {
  String get configRequisitionTypeExplanationName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeExplanationEnum.early:
        return appLocalizations.leaveEarly;
      case RequisitionTypeExplanationEnum.late:
        return appLocalizations.late;
      case RequisitionTypeExplanationEnum.other:
        return appLocalizations.other;
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

enum RequisitionDeliveryTypeEnum {
  @JsonValue('Standard')
  standard("Standard"),
  @JsonValue('Express')
  express("Express"),
  @JsonValue('SameDay')
  sameDay("SameDay"),
  @JsonValue('Overnight')
  overnight("Overnight"),
  @JsonValue('TwoDay')
  twoDay("TwoDay"),
  @JsonValue('Economy')
  economy("Economy"),
  @JsonValue('Rush')
  rush("Rush"),
  @JsonValue('Scheduled')
  scheduled("Scheduled");

  final String name;

  const RequisitionDeliveryTypeEnum(this.name);
}

extension ConfigDeliveryTypeExtension on RequisitionDeliveryTypeEnum {
  String get configDeliveryTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionDeliveryTypeEnum.standard:
        return appLocalizations.standard;
      case RequisitionDeliveryTypeEnum.express:
        return appLocalizations.express;
      case RequisitionDeliveryTypeEnum.sameDay:
        return appLocalizations.sameDay;
      case RequisitionDeliveryTypeEnum.overnight:
        return appLocalizations.overnight;
      case RequisitionDeliveryTypeEnum.twoDay:
        return appLocalizations.twoDay;
      case RequisitionDeliveryTypeEnum.economy:
        return appLocalizations.economy;
      case RequisitionDeliveryTypeEnum.rush:
        return appLocalizations.rush;
      case RequisitionDeliveryTypeEnum.scheduled:
        return appLocalizations.scheduled;
    }
  }
}
