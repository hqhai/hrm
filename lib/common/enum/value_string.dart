import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

enum TypeRequestStatus {
  overTime('OverTime'),
  onLeave('OnLeave'),
  explanation('Explanation'),
  roomMeeting('RoomMeeting'),
  cRM('CRM'),
  iT('IT'),
  website('Website');

  final String name;

  const TypeRequestStatus(this.name);
}

enum PriorityRequestStatus {
  high('High'),
  medium('Medium'),
  low('Low');

  final String name;

  const PriorityRequestStatus(this.name);
}

enum ParentId {
  aG('Atlantic group'),
  fsel('Five-star E-Learning');

  final String name;

  const ParentId(this.name);
}

enum LanguageEnum {
  vi('Tiếng Việt', 'vi'),
  en('English', 'en');

  final String name;
  final String code;

  const LanguageEnum(this.name, this.code);
}

enum LocationEnum {
  country('Country'),
  province('Province'),
  district('District'),
  ward('Ward');

  final String name;

  const LocationEnum(this.name);
}

enum WeekDayEnum {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  final String name;

  const WeekDayEnum(this.name);
}

extension ConfigWeekDayEnumExtension on WeekDayEnum {
  String get configWeekDayEnumName {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    switch (this) {
      case WeekDayEnum.monday:
        return appLocalizations.monday;
      case WeekDayEnum.tuesday:
        return appLocalizations.tuesday;
      case WeekDayEnum.wednesday:
        return appLocalizations.wednesday;
      case WeekDayEnum.thursday:
        return appLocalizations.thursday;
      case WeekDayEnum.friday:
        return appLocalizations.friday;
      case WeekDayEnum.saturday:
        return appLocalizations.saturday;
      case WeekDayEnum.sunday:
        return appLocalizations.sunday;
    }
  }
}
