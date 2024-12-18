import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

class TitleHome {
  static List<String> titleHome() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    return [
      appLocalizations.realWork,
      appLocalizations.actualWork,
      appLocalizations.leaveWork,
      appLocalizations.i18nCompensatoryLeave,
      appLocalizations.holidayWork,
      appLocalizations.salaryWork,
      appLocalizations.leaveWithoutPay,
      appLocalizations.oTSalaryH,
      appLocalizations.oTMakeUpLeaveH,
      appLocalizations.workTime,
      appLocalizations.minutesToLate,
      appLocalizations.minutesToEarly,
      appLocalizations.numberOfEarly,
      appLocalizations.numberOfLate,
    ];
  }
}
