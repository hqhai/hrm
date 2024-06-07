import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final seeListRequisitionPageRoute = GoRoute(
    path: Pages.seeRequisitionListPage,
    name: Pages.seeRequisitionListPage,
    builder: (context, GoRouterState state) => const SeeListRequisitionPage());

class SeeListRequisitionPage extends StatefulWidget {
  const SeeListRequisitionPage({super.key});

  @override
  State<SeeListRequisitionPage> createState() => _SeeListRequisitionPageState();
}

class _SeeListRequisitionPageState extends State<SeeListRequisitionPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.singleWordList,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x6
            )),
      ),
      body: Container(
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
                title: appLocalizations.yourRequisition,
                callback: () => _nextRequisitionListScreen(context),),
            ItemActivateWidget(
                iconPath: Assets.images.icon.activateIcon.materialSymbolsLightListAltOutline,
                title: appLocalizations.requisitionYouApproval,
                callback: () => _nextRequisitionApproveListScreen(context),),
            ItemActivateWidget(
                iconPath: Assets.images.icon.activateIcon.materialSymbolsLightListAltOutline,
                title: appLocalizations.requisitionYouFollow,
                callback: () => {}),
          ],
        ),
      ),
    );
  }

  _nextRequisitionListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.requisitionListPage);
  }

  _nextRequisitionApproveListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.requisitionApproveListPage);
  }
}
