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
