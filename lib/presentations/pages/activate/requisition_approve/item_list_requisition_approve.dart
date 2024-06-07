import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/content_item_requisition_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionApproveList extends StatefulWidget {
  const ItemRequisitionApproveList({
    super.key,
    this.index = 0,
  });

  final int index;

  @override
  State<ItemRequisitionApproveList> createState() => _ItemRequisitionApproveListState();
}

class _ItemRequisitionApproveListState extends State<ItemRequisitionApproveList> {
  @override
  void initState() {
    super.initState();
  }

  bool _check(RequisitionApproveState state) {
    return state.requisitions[widget.index].status != StatusRequisitionEnum.done &&
        state.requisitions[widget.index].status != StatusRequisitionEnum.pending;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) => Container(
        height: _check(state) ? height * 0.15 : height * 0.18,
        margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x1),
          color: CustomsColor.colorBackground,
          border: Border.all(color: colors.text, width: 1),
        ),
        child: GestureDetector(
          onTap: () => _nextRequisitionInformationScreen(context, state),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  color: colors.neutralVariant40,
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: Text(
                    StatusRequisitionEnum.values
                        .firstWhere((e) => e == state.requisitions[widget.index].status)
                        .configStatusName,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                  ),
                ),
              ),
              if (state.requisitions[widget.index].status == StatusRequisitionEnum.done)
                Align(
                  alignment: Alignment.bottomRight,
                  child: ButtonItemListRequisition(
                    title: appLocalizations.cancel,
                    callback: () {},
                  ),
                ),
              if (state.requisitions[widget.index].status == StatusRequisitionEnum.pending)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonItemListRequisition(
                        title: appLocalizations.approver,
                        callback: () {},
                      ),
                      ButtonItemListRequisition(
                        title: appLocalizations.refuse,
                        callback: () {},
                      ),
                      ButtonItemListRequisition(
                        title: appLocalizations.modification,
                        callback: () {},
                      ),
                    ],
                  ),
                ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: ContentItemRequisitionList(index: widget.index),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _nextRequisitionInformationScreen(BuildContext context, RequisitionApproveState state) {
    dI<AppNavigation>().pushName(context, page: Pages.requisitionInformationPage, extra: {
      'requisition': state.requisitions[widget.index],
      'checkUser': true,
    });
  }
}
