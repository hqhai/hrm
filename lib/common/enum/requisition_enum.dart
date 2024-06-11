import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

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
        return appLocalizations.approver;
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
        return appLocalizations.approver;
      case StatusRequestEnum.cancel:
        return appLocalizations.cancel;
      case StatusRequestEnum.overdueEdit:
        return appLocalizations.overdueEdit;
      case StatusRequestEnum.overdueApprove:
        return appLocalizations.overdueApprove;
    }
  }
}

enum RequisitionTypeEnum {
  @JsonValue('TakeLeave')
  takeLeave('TakeLeave'),
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
      case RequisitionTypeEnum.takeLeave:
        return appLocalizations.leave;
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

enum RequisitionDeliveryTypeEnum {
  standard("Standard"),
  express("Express"),
  sameDay("SameDay"),
  overnight("Overnight"),
  twoDay("TwoDay"),
  economy("Economy"),
  rush("Rush"),
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

enum RequestWarehouseReleasedsUnitTypeEnum {
  pieces('Pieces'),
  rolls('rolls'),
  boxes('boxes'),
  jars('jars'),
  books('books'),
  reams('reams'),
  volumes('volumes'),
  bags('Bags'),
  blisters('blisters'),
  pairs('Pairs');

  final String name;

  const RequestWarehouseReleasedsUnitTypeEnum(this.name);
}

extension ConfigRequisitionStationeryUnitTypeExtension on RequestWarehouseReleasedsUnitTypeEnum {
  String get configRequisitionStationeryUnitTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequestWarehouseReleasedsUnitTypeEnum.pieces:
        return appLocalizations.pieces;
      case RequestWarehouseReleasedsUnitTypeEnum.rolls:
        return appLocalizations.rolls;
      case RequestWarehouseReleasedsUnitTypeEnum.boxes:
        return appLocalizations.boxes;
      case RequestWarehouseReleasedsUnitTypeEnum.jars:
        return appLocalizations.jars;
      case RequestWarehouseReleasedsUnitTypeEnum.books:
        return appLocalizations.books;
      case RequestWarehouseReleasedsUnitTypeEnum.reams:
        return appLocalizations.reams;
      case RequestWarehouseReleasedsUnitTypeEnum.volumes:
        return appLocalizations.volumes;
      case RequestWarehouseReleasedsUnitTypeEnum.bags:
        return appLocalizations.bags;
      case RequestWarehouseReleasedsUnitTypeEnum.blisters:
        return appLocalizations.blisters;
      case RequestWarehouseReleasedsUnitTypeEnum.pairs:
        return appLocalizations.pairs;
    }
  }
}
