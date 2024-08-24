import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

enum DayOfWeekEnum {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun,
}

extension ConfigDayOfWeekExtension on DayOfWeekEnum {
  String get configDayOfWeekName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case DayOfWeekEnum.mon:
        return appLocalizations.mon;
      case DayOfWeekEnum.tue:
        return appLocalizations.tue;
      case DayOfWeekEnum.wed:
        return appLocalizations.wed;
      case DayOfWeekEnum.thu:
        return appLocalizations.thu;
      case DayOfWeekEnum.fri:
        return appLocalizations.fri;
      case DayOfWeekEnum.sat:
        return appLocalizations.sat;
      case DayOfWeekEnum.sun:
        return appLocalizations.sun;
    }
  }
}

enum MonthEnum {
  january,
  february,
  march,
  april,
  may,
  july,
  june,
  august,
  september,
  october,
  november,
  december
}

extension ConfigMonthExtension on MonthEnum {
  String get configMonthName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case MonthEnum.january:
        return appLocalizations.january;
      case MonthEnum.february:
        return appLocalizations.february;
      case MonthEnum.march:
        return appLocalizations.march;
      case MonthEnum.april:
        return appLocalizations.april;
      case MonthEnum.may:
        return appLocalizations.may;
      case MonthEnum.june:
        return appLocalizations.june;
      case MonthEnum.august:
        return appLocalizations.august;
      case MonthEnum.september:
        return appLocalizations.september;
      case MonthEnum.october:
        return appLocalizations.october;
      case MonthEnum.november:
        return appLocalizations.november;
      case MonthEnum.december:
        return appLocalizations.december;
      case MonthEnum.july:
        return appLocalizations.july;
    }
  }
}
