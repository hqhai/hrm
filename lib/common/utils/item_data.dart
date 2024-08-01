import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

final List<int> listActivate = [0, 1, 2, 3, 4];
final List<int> listCalendarWork = [0, 1];

String imagePathActivate(int index) {
  final Map<int, String> imagePathActivate = {
    0: Assets.images.icon.activateIcon.materialSymbolsLightListAltOutline,
    1: Assets.images.icon.activateIcon.materialSymbolsLightListAltAddOutline,
    2: Assets.images.icon.home.mingcuteTimeLine,
    3: Assets.images.timeKeeping.calendar,
    4: Assets.images.icon.home.phFingerprintFill,
  };
  return imagePathActivate[index] ?? '';
}

String titlesActivate(int index, BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  final Map<int, String> title = {
    0: appLocalizations.singleWordList,
    1: appLocalizations.createANewSingleWord,
    2: appLocalizations.leaveManagement,
    3: appLocalizations.registerShift,
    4: appLocalizations.timeKeeping,
  };
  return title[index] ?? "";
}

String titlesCalendarWork(int index, BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  final Map<int, String> title = {
    0: appLocalizations.registerShift,
    1: appLocalizations.shiftManagement,
  };
  return title[index] ?? "";
}

List<String> titlesTabBar(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  final List<String> titles = [appLocalizations.leaveList, appLocalizations.leaveUseHistory];
  return titles;
}
