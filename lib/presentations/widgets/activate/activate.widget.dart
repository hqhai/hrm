import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
      margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
      decoration: BoxDecoration(
        color: CustomsColor.colorBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(SpacingUnit.x4),
        ),
      ),
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
        ],
      ),
    );
  }

  _nextRequisitionListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.seeRequisitionListPage);
  }
  _nextCreateRequisitionScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionPage);
  }
}
