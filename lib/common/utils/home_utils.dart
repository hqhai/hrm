import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/l10n/app_localizations.dart';

List<String> titleHome(){
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocailzations = AppLocalizations.of(currentContext)!;
  return [
    appLocailzations.actualWork,
    appLocailzations.leaveWork,
    appLocailzations.noSalaryWork,
    appLocailzations.overtime,
    appLocailzations.workTime,
    appLocailzations.timeLate,
    appLocailzations.timeEarly,
    appLocailzations.salaryWork,
    appLocailzations.realWork
  ];
}