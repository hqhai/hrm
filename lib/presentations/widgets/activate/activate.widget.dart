import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';

class ActivateWidget extends StatefulWidget {
  const ActivateWidget({super.key});

  @override
  State<ActivateWidget> createState() => _ActivateWidgetState();
}

class _ActivateWidgetState extends State<ActivateWidget> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ContainerScreenMain(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ItemActivateWidget(
                iconPath: Assets.images.icon.activateIcon.materialSymbolsLightListAltOutline,
                title: appLocalizations.singleWordList,
                callback: () => _nextRequisitionListScreen(context)),
            ItemActivateWidget(
                iconPath: Assets.images.icon.activateIcon.materialSymbolsLightListAltAddOutline,
                title: appLocalizations.createANewSingleWord,
                callback: () => _nextCreateRequisitionScreen(context)),
            ItemActivateWidget(
                iconPath: Assets.images.icon.home.mingcuteTimeLine,
                title: appLocalizations.leaveManagement,
                callback: () => _nextTimekeepingGPSScreen(context)),
            ItemActivateWidget(
                iconPath: Assets.images.timeKeeping.calendar,
                title: appLocalizations.registerShift,
                callback: () => _nextTimekeepingGPSScreen(context)),
            ItemActivateWidget(
                iconPath: Assets.images.icon.home.phFingerprintFill,
                title: appLocalizations.timeKeeping,
                callback: () => _nextTimekeepingGPSScreen(context)),
          ],
        ),
      ),
    );
  }

  _nextRequisitionListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.seeRequestListPage);
  }
  _nextCreateRequisitionScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestPage);
  }
  _nextTimekeepingGPSScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.listSchoolsPage);
  }
}
