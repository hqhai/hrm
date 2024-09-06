import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum EnumTakeLeaveType {
  @JsonValue('YearlyLeaveAndSeniorityLeave')
  yearlyLeaveAndSeniorityLeave('YearlyLeaveAndSeniorityLeave'),
  @JsonValue('UnpaidLeave')
  unpaidLeave('UnpaidLeave'),
  @JsonValue('CompensatoryLeave')
  compensatoryLeave('CompensatoryLeave'),
  @JsonValue('OtherPaidLeave')
  otherPaidLeave('OtherPaidLeave'),
  @JsonValue('')
  unknown('');

  final String name;

  const EnumTakeLeaveType(this.name);
}

extension ConfigTakeLeaveTypeExtension on EnumTakeLeaveType {
  String get configTakeLeaveTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave:
        return appLocalizations.yearlyAndSeniorityLeave;
      case EnumTakeLeaveType.unpaidLeave:
        return appLocalizations.unpaidLeave;
      case EnumTakeLeaveType.compensatoryLeave:
        return appLocalizations.compensatoryLeave;
      case EnumTakeLeaveType.otherPaidLeave:
        return appLocalizations.otherPaidLeave;
      case EnumTakeLeaveType.unknown:
      default:
        return '';
    }
  }
}

enum EnumSocialInsuranceLeave {
  @JsonValue('HomeSickLeave')
  homeSickLeave('HomeSickLeave'),
  @JsonValue('HospitalSickLeave')
  hospitalSickLeave('HospitalSickLeave'),
  @JsonValue('MaternityLeave')
  maternityLeave('MaternityLeave'),
  @JsonValue('')
  unknown('');

  final String name;

  const EnumSocialInsuranceLeave(this.name);
}

extension ConfigSocialInsuranceLeaveExtension on EnumSocialInsuranceLeave {
  String get configSocialInsuranceLeaveName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumSocialInsuranceLeave.homeSickLeave:
        return appLocalizations.homeSickLeave;
      case EnumSocialInsuranceLeave.hospitalSickLeave:
        return appLocalizations.hospitalSickLeave;
      case EnumSocialInsuranceLeave.maternityLeave:
        return appLocalizations.maternityLeave;
      default:
        return '';
    }
  }
}

enum EnumReasonLeave {
  @JsonValue('YearlyLeave')
  yearlyLeave('YearlyLeave'),
  @JsonValue('SeniorityLeave')
  seniorityLeave('SeniorityLeave'),
  @JsonValue('NoSalaryLeave')
  noSalaryLeave('NoSalaryLeave'),
  @JsonValue('SocialInsuranceLeave')
  socialInsuranceLeave('SocialInsuranceLeave'),
  @JsonValue('WeddingLeave')
  weddingLeave('WeddingLeave'),
  @JsonValue('MourningLeave')
  mourningLeave('MourningLeave'),
  @JsonValue('')
  unknown('');

  final String name;

  const EnumReasonLeave(this.name);
}

extension ConfigEnumTakeLeaveExtension on EnumReasonLeave {
  String get configEnumTakeLeaveName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumReasonLeave.yearlyLeave:
        return appLocalizations.yearlyLeave;
      case EnumReasonLeave.seniorityLeave:
        return appLocalizations.seniorityLeave;
      case EnumReasonLeave.weddingLeave:
        return appLocalizations.weddingLeave;
      case EnumReasonLeave.mourningLeave:
        return appLocalizations.mourningLeave;
      case EnumReasonLeave.noSalaryLeave:
        return appLocalizations.leaveWithoutPay;
      case EnumReasonLeave.socialInsuranceLeave:
        return appLocalizations.socialInsuranceLeave;
      default:
        return '';
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
  overdueApprove('OverdueApprove'),
  @JsonValue('Cancel')
  cancel('Cancel'),
  @JsonValue('')
  unknown('');

  final String name;

  const EnumStepRequestStatusEnum(this.name);
}

extension ConfigStepRequestStatusExtension on EnumStepRequestStatusEnum {
  String get configStepRequestStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumStepRequestStatusEnum.newStatus:
        return appLocalizations.process;
      case EnumStepRequestStatusEnum.approve:
        return appLocalizations.done;
      case EnumStepRequestStatusEnum.reject:
        return appLocalizations.reject;
      case EnumStepRequestStatusEnum.edit:
        return appLocalizations.edit;
      case EnumStepRequestStatusEnum.overdueApprove:
        return appLocalizations.overdueApprove;
      case EnumStepRequestStatusEnum.cancel:
        return appLocalizations.cancel;
      default:
        return '';
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
  overdueApprove('OverdueApprove'),
  @JsonValue('')
  unknown('');

  final String name;

  const StatusRequestEnum(this.name);
}

extension ConfigRequestStatusExtension on StatusRequestEnum {
  String get getAppLocalizationName {
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
      default:
        return '';
    }
  }
}

enum EnumStepFlowType {
  @JsonValue('Start')
  start('Start'),
  @JsonValue('Step')
  step('Step'),
  @JsonValue('End')
  end('End'),
  @JsonValue('')
  unknown('');

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
      default:
        return '';
    }
  }
}

enum RequisitionTypeEnum {
  @JsonValue('LeaveHalfDayToOneDay')
  leaveHalfDayToOneDay('LeaveHalfDayToOneDay'),
  @JsonValue('LeaveTwoDayToFourDay')
  leaveTwoDayToFourDay('LeaveTwoDayToFourDay'),
  @JsonValue('LeaveFiveDaysOrMore')
  leaveFiveDaysOrMore('LeaveFiveDaysOrMore'),
  @JsonValue('LateOrEarly')
  lateOrEarly('LateOrEarly'),
  @JsonValue('Bussiness')
  bussiness('Bussiness'),
  @JsonValue('OverTime')
  overTime('OverTime'),
  @JsonValue('VehicleDriver')
  vehicleDriver('VehicleDriver'),
  @JsonValue('WarehouseReleased')
  warehouseReleased('WarehouseReleased'),
  @JsonValue('Stationery')
  stationery('Stationery'),
  @JsonValue('Explanation')
  explanation('Explanation'),
  @JsonValue('MakeUpWork')
  makeUpWork('MakeUpWork'),
  @JsonValue('PostalDelivery')
  postalDelivery('PostalDelivery'),
  @JsonValue('Core')
  core('Core'),
  @JsonValue('')
  unknown('');

  final String name;

  const RequisitionTypeEnum(this.name);
}

extension ConfigTypeFilter on RequisitionTypeEnum {
  String get configTypeNameFilter {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeEnum.explanation:
        return appLocalizations.explanationF;
      case RequisitionTypeEnum.overTime:
        return appLocalizations.oT;
      case RequisitionTypeEnum.vehicleDriver:
        return appLocalizations.vehicleF;
      case RequisitionTypeEnum.postalDelivery:
        return appLocalizations.postal;
      case RequisitionTypeEnum.warehouseReleased:
        return appLocalizations.releaseOfWarehouseF;
      case RequisitionTypeEnum.stationery:
        return appLocalizations.stationery;
      case RequisitionTypeEnum.bussiness:
        return appLocalizations.businessF;
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        return appLocalizations.halfDayToOneDay;
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        return appLocalizations.twoDayToFourDay;
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        return appLocalizations.fiveDaysOrMore;
      case RequisitionTypeEnum.lateOrEarly:
        return appLocalizations.earlyLate;
      case RequisitionTypeEnum.makeUpWork:
        return appLocalizations.makeUpWork;
      case RequisitionTypeEnum.core:
        return appLocalizations.core;
      case RequisitionTypeEnum.unknown:
      default:
        return '';
    }
  }
}

extension ConfigTypeCreate on RequisitionTypeEnum {
  String get configTypeCreateName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case RequisitionTypeEnum.explanation:
        return appLocalizations.explanation;
      case RequisitionTypeEnum.overTime:
        return appLocalizations.overtimeCreate;
      case RequisitionTypeEnum.vehicleDriver:
        return appLocalizations.vehicleDispatchCreate;
      case RequisitionTypeEnum.postalDelivery:
        return appLocalizations.postalDelivery;
      case RequisitionTypeEnum.warehouseReleased:
        return appLocalizations.releaseOfWarehouseCreate;
      case RequisitionTypeEnum.stationery:
        return appLocalizations.stationeryOrderCreate;
      case RequisitionTypeEnum.bussiness:
        return appLocalizations.businessCreate;
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        return appLocalizations.halfDayToOneDayCreate;
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        return appLocalizations.twoDayToFourDayCreate;
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        return appLocalizations.fiveDaysOrMoreCreate;
      case RequisitionTypeEnum.lateOrEarly:
        return appLocalizations.lateOrEarlyCreate;
      case RequisitionTypeEnum.makeUpWork:
        return appLocalizations.createMakeUpWork;
      case RequisitionTypeEnum.core:
        return appLocalizations.core;
      case RequisitionTypeEnum.unknown:
      default:
        return '';
    }
  }
}

extension ConfigTypeExtension on RequisitionTypeEnum {
  String get configTypeName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
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
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        return appLocalizations.halfDayToOneDay;
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        return appLocalizations.twoDayToFourDay;
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        return appLocalizations.fiveDaysOrMore;
      case RequisitionTypeEnum.lateOrEarly:
        return appLocalizations.earlyLate;
      case RequisitionTypeEnum.makeUpWork:
        return appLocalizations.makeUpWork;
      case RequisitionTypeEnum.core:
        return appLocalizations.core;
      case RequisitionTypeEnum.unknown:
      default:
        return '';
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
      default:
        return '';
    }
  }
}

enum RequisitionTypeOnLeaveEnum {
  annualLeave('Annual leave'),
  compensatoryLeave('Compensatory leave'),
  sickLeave('Sick leave'),
  otherPaidLeave('Other paid leave'),
  leaveWithoutPay('Leave without pay'),
  other('Other'),
  @JsonValue('')
  unknown('');

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
      default:
        return '';
    }
  }
}

enum RequisitionDeliveryTypeEnum {
  @JsonValue('Standard')
  standard("Standard"),
  @JsonValue('Express')
  express("Express"),
  @JsonValue('')
  unknown('');

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
      default:
        return '';
    }
  }
}

enum EnumReason {
  @JsonValue('Individual')
  individual('Individual'),
  @JsonValue('Work')
  work('Work'),
  @JsonValue('')
  unknown('');

  final String name;

  const EnumReason(this.name);
}

extension ConfigEnumReasonExtension on EnumReason {
  String get configEnumReasonName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumReason.individual:
        return appLocalizations.personalReasons;
      case EnumReason.work:
        return appLocalizations.companyReasons;
      default:
        return '';
    }
  }
}
