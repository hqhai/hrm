import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition/popup_menu_requisition_list.dart';
import 'package:base_app/presentations/pages/activate/requisition/wrap_filter.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/item_list_requisition_approve.dart';
import 'package:base_app/presentations/widgets/dialog/filter_requisition_approve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionApproveListPageRoute = GoRoute(
    path: Pages.requisitionApproveListPage,
    name: Pages.requisitionApproveListPage,
    builder: (context, GoRouterState state) => const RequisitionApproveListPage());

class RequisitionApproveListPage extends StatefulWidget {
  const RequisitionApproveListPage({super.key});

  @override
  State<RequisitionApproveListPage> createState() => _RequisitionApproveListPageState();
}

class _RequisitionApproveListPageState extends State<RequisitionApproveListPage> {
  bool checkOpacity = false;
  var random = Random();

  List<StatusRequestEnum> listFilter = [];

  @override
  void initState() {
    dI<RequisitionApproveBloc>().add(const GetRequisitionsApproveEvent(page: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
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
        child: BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
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
                          child: WrapFilter(
                            listFilter: listFilter,
                            onChange: (value) => removeListFilter(value),
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => dialog(context),
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
                  height: height * 0.78,
                  decoration: BoxDecoration(
                    color: CustomsColor.colorBackground,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(SpacingUnit.x1),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: height * 0.75,
                      child: ListView.builder(
                        itemCount: state.requisitions.length,
                        itemBuilder: (context, index) => ItemRequisitionApproveList(index: index),
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

  removeListFilter(StatusRequestEnum e) {
    setState(() {
      listFilter.remove(e);
    });
  }

  setlLstFilter(List<StatusRequestEnum> statuses) {
    setState(() {
      listFilter = statuses;
    });
  }

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: FilterRequisitionApproveDialog(
            sendData: (value) => setlLstFilter(value.statuses),
          ),
        );
      },
    );
  }
}
