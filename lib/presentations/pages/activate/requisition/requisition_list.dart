import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition/item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition/popup_menu_requisition_list.dart';
import 'package:base_app/presentations/widgets/dialog/filter_requisition_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<String> listFilter = [];

  @override
  void initState() {
    dI<RequisitionBloc>().add(const GetRequisitionsEvent());
    super.initState();
  }

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
        actions: [PopupMenuRequisitionList(onChangeCheckOpacity: (value) => _opacity(value))],
      ),
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: BlocBuilder<RequisitionBloc, RequisitionState>(
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: height * 0.04,
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  child: Stack(
                    children: [
                      if (listFilter.isEmpty)
                        Container(
                          width: width * 0.5,
                          padding: const EdgeInsets.all(
                            SpacingUnit.x1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              SpacingUnit.x1,
                            ),
                            color: CustomsColor.colorBackground,
                            border: Border.all(
                              color: colors.text,
                              width: SpacingUnit.x0_25,
                            ),
                          ),
                          child: Text(appLocalizations.all,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                        ),
                      if (listFilter.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: SpacingUnit.x4,
                            runSpacing: SpacingUnit.x3,
                            children: listFilter
                                .map((e) => GestureDetector(
                                      onTap: () => listFilter.remove(e),
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                          SpacingUnit.x1,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            SpacingUnit.x1,
                                          ),
                                          color: CustomsColor.colorBackground,
                                          border: Border.all(
                                            color: colors.text,
                                            width: SpacingUnit.x0_25,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              e,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: colors.text, fontSize: SpacingUnit.x3),
                                            ),
                                            const SizedBox(
                                              width: SpacingUnit.x1,
                                            ),
                                            GestureDetector(
                                              onTap: () => setState(() {
                                                listFilter.remove(e);
                                              }),
                                              child: Icon(
                                                Icons.cancel_outlined,
                                                size: SpacingUnit.x5,
                                                color: colors.error,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: FilterRequisitionDialog(
                                  sendData: (value) => setState(() {
                                    listFilter = value.statuses;
                                  }),
                                ),
                              );
                            },
                          ),
                          child: Container(
                            color: colors.background,
                            height: height * 0.04,
                            child: SvgPicture.asset(
                              Assets.images.icon.activateIcon.iconamoonOptionsThin,
                              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  height: height * 0.75,
                  decoration: BoxDecoration(
                    color: CustomsColor.colorBackground,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(SpacingUnit.x1),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: height * 0.6,
                      child: ListView.builder(
                        itemCount: state.requisitions.length,
                        itemBuilder: (context, index) => ItemRequisitionList(index: index),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
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
