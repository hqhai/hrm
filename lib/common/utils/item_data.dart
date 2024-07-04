import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';


final List<int> listActivate = [0, 1, 2, 3, 4];

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

String titlesActivate(int index) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  final Map<int, String> title = {
    0: appLocalizations.singleWordList,
    1: appLocalizations.createANewSingleWord,
    2: appLocalizations.leaveManagement,
    3: appLocalizations.registerShift,
    4: appLocalizations.timeKeeping,
  };
  return title[index] ?? "";
}