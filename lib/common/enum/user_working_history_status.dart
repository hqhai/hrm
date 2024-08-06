import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum UserWorkingHistoryStatus {
  @JsonValue('OnTime')
  onTime('OnTime'),
  @JsonValue('Late')
  late('Late'),
  @JsonValue('Early')
  early('Early'),
  @JsonValue('ForgotChecking')
  forgotChecking('ForgotChecking'),
  @JsonValue('OffWork')
  offWork('OffWork'),
  @JsonValue('IsRequest')
  isRequest('IsRequest'),
  @JsonValue('Holiday')
  holiday('Holiday'),
  @JsonValue('NoAttendance')
  noAttendance('NoAttendance'),
  @JsonValue('OffSet')
  offSet('OffSet'),
  @JsonValue('Invalid')
  invalid('Invalid');

  final String name;

  const UserWorkingHistoryStatus(this.name);
}

extension ConfigUesrWorkingHistoryStatusExtension on UserWorkingHistoryStatus {
  String get configUserWorkingHistoryStatusName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case UserWorkingHistoryStatus.onTime:
        return appLocalizations.onTime;
      case UserWorkingHistoryStatus.late:
        return appLocalizations.timeLate;
      case UserWorkingHistoryStatus.early:
        return appLocalizations.timeEarly;
      case UserWorkingHistoryStatus.forgotChecking:
        return appLocalizations.forgotChecking;
      case UserWorkingHistoryStatus.offWork:
        return appLocalizations.offWork;
      case UserWorkingHistoryStatus.isRequest:
        return appLocalizations.isRequest;
      case UserWorkingHistoryStatus.holiday:
        return appLocalizations.holiday;
      case UserWorkingHistoryStatus.noAttendance:
        return appLocalizations.noAttendance;
      case UserWorkingHistoryStatus.offSet:
        return appLocalizations.offSet;
      case UserWorkingHistoryStatus.invalid:
        return appLocalizations.invalid;
    }
  }
}

enum EnumOvertimeDay {
  @JsonValue('Holiday')
  holiday('Holiday'),
  @JsonValue('NoShiftsWork')
  noShiftsWork('NoShiftsWork'),
  @JsonValue('Saturday')
  saturday('Saturday'),
  @JsonValue('Sunday')
  sunday('Sunday'),
  @JsonValue('RegularDay')
  regularDay('RegularDay');

  final String name;

  const EnumOvertimeDay(this.name);
}

extension ConfigUesrEnumOvertimeDayExtension on EnumOvertimeDay {
  String get configEnumOvertimeDayName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case EnumOvertimeDay.holiday:
        return appLocalizations.holiday;
      case EnumOvertimeDay.noShiftsWork:
        return appLocalizations.noShiftsWork;
      case EnumOvertimeDay.saturday:
        return appLocalizations.saturday;
      case EnumOvertimeDay.sunday:
        return appLocalizations.sunday;
      case EnumOvertimeDay.regularDay:
        return appLocalizations.regularDay;
    }
  }
}

enum CheckInMethodEnum {
  @JsonValue('Fingerprint')
  fingerprint('Fingerprint'),
  @JsonValue('GPS')
  gPS('GPS'),
  @JsonValue('All')
  all('All'),
  @JsonValue('None')
  none('None');

  final String name;

  const CheckInMethodEnum(this.name);
}

extension ConfigCheckInMethodEnumExtension on CheckInMethodEnum {
  String get configCheckInMethodEnumName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case CheckInMethodEnum.fingerprint:
        return appLocalizations.fingerprint;
      case CheckInMethodEnum.gPS:
        return appLocalizations.gPS;
      case CheckInMethodEnum.all:
        return appLocalizations.all;
      case CheckInMethodEnum.none:
        return appLocalizations.none;
    }
  }
}
