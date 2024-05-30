import 'dart:math';

import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition/item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition/popup_menu_requisition_list.dart';
import 'package:base_app/presentations/widgets/dialog/filter_requisition_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionListPageRoute = GoRoute(
    path: Pages.requisitionListPage,
    name: Pages.requisitionListPage,
    builder: (context, GoRouterState state) => const RequisitionListPage());

class RequisitionListPage extends StatefulWidget {
  const RequisitionListPage({super.key});

  @override
  State<RequisitionListPage> createState() => _RequisitionListPageState();
}

class _RequisitionListPageState extends State<RequisitionListPage> {
  bool checkOpacity = false;
  var random = Random();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: (Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        )),
        actions: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.images.icon.activateIcon.materialSymbolsLightSearch,
                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
              ),
              PopupMenuRequisitionList(onChangeCheckOpacity: (value) => _opacity(value))
            ],
          )
        ],
      ),
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height * 0.04,
                    color: colors.neutralVariant40,
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x0_5),
                      child: Row(
                        children: [
                          Text(appLocalizations.all,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                          const SizedBox(
                            width: SpacingUnit.x2,
                          ),
                          Icon(
                            Icons.cancel,
                            color: colors.text,
                            size: SpacingUnit.x4,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => filterRequisitionDialog(context, (value) => value),
                    child: SvgPicture.asset(
                      Assets.images.icon.activateIcon.iconamoonOptionsThin,
                      colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
              margin:
                  const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
              height: height * 0.75,
              decoration: BoxDecoration(
                color: CustomsColor.colorBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(SpacingUnit.x1),
                ),
              ),
              child: SizedBox(
                height: height * 0.6,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => ItemRequisitionList(
                      indexType: random.nextInt(7), indexStatus: random.nextInt(4)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _opacity(bool check) {
    setState(() {
      checkOpacity = check;
    });
  }
}
