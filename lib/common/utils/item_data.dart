import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class ItemUtils {
  static List<int> listActivate = [0, 1, 2, 3];
  static List<int> listCalendarWork = [0, 1, 2];

  static String imagePathActivate(int index) {
    final Map<int, String> imagePathActivate = {
      0: Assets.images.icon.activateIcon.materialSymbolsLightListAltOutline,
      1: Assets.images.icon.activateIcon.materialSymbolsLightListAltAddOutline,
      2: Assets.images.icon.home.mingcuteTimeLine,
      3: Assets.images.icon.home.phFingerprintFill,
    };
    return imagePathActivate[index] ?? '';
  }

  static String titlesActivate(int index, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final Map<int, String> title = {
      0: appLocalizations.leaveManagement,
      1: appLocalizations.yourRequisition,
      2: appLocalizations.requisitionYouApproval,
      3: appLocalizations.requisitionYouFollow,
    };
    return title[index] ?? "";
  }

  static String titlesCalendarWork(int index, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final Map<int, String> title = {
      0: appLocalizations.registerShift,
      1: appLocalizations.shiftManagement,
      2: appLocalizations.timeKeeping,
    };
    return title[index] ?? "";
  }

  static List<String> titlesTabBar(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final List<String> titles = [appLocalizations.leaveList, appLocalizations.leaveUseHistory];
    return titles;
  }
}
