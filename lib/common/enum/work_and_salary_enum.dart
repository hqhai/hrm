import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

enum WorkAndSalaryStatusEnum {
  init,
  start,
  success,
  fail,
}

enum ChangeTypeEnum {
  @JsonValue('Addition')
  addition('Addition'),
  @JsonValue('Subtraction')
  subtraction('Subtraction');

  final String name;

  const ChangeTypeEnum(this.name);
}

extension ConfigChangeTypeExtension on ChangeTypeEnum {
  String get configChangeTypeEnum {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case ChangeTypeEnum.addition:
        return appLocalizations.addition;
      case ChangeTypeEnum.subtraction:
        return appLocalizations.subtraction;
    }
  }
}

enum TimeUnitEnum {
  @JsonValue('Day')
  day('Day'),
  @JsonValue('Hour')
  hour('Hour');

  final String name;

  const TimeUnitEnum(this.name);
}

extension ConfigTimeUnitExtension on TimeUnitEnum {
  String get configTimeUnitEnum {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case TimeUnitEnum.day:
        return appLocalizations.day;
      case TimeUnitEnum.hour:
        return appLocalizations.hour;
    }
  }
}

enum TypeLeaveEnum {
  @JsonValue('Total')
  total('Total'),
  @JsonValue('AnnualLeave')
  annualLeave('AnnualLeave'),
  @JsonValue('SeniorityLeave')
  seniorityLeave('SeniorityLeave'),
  @JsonValue('OverTimeLeave')
  overTimeLeave('OverTimeLeave');

  final String name;

  const TypeLeaveEnum(this.name);
}

extension ConfigTypeLeaveExtension on TypeLeaveEnum {
  String get configTypeLeaveEnum {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case TypeLeaveEnum.annualLeave:
        return appLocalizations.annualLeave;
      case TypeLeaveEnum.seniorityLeave:
        return appLocalizations.seniorityLeave;
      case TypeLeaveEnum.overTimeLeave:
        return appLocalizations.overTimeLeave;
      case TypeLeaveEnum.total:
        return appLocalizations.total;
    }
  }
}


