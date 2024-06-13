import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/content_item_requisition_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionApproveList extends StatefulWidget {
  final String id;

  const ItemRequisitionApproveList({
    super.key,
    this.id = '',
  });

  @override
  State<ItemRequisitionApproveList> createState() => _ItemRequisitionApproveListState();
}

class _ItemRequisitionApproveListState extends State<ItemRequisitionApproveList> {
  @override
  void initState() {
    super.initState();
  }

  bool _check(RequisitionApproveState state, String id) {
    final requisitions = state.requisitions.firstWhere((element) => element.id == id);
    return requisitions.status != StatusRequestEnum.approve &&
        requisitions.status != StatusRequestEnum.process;
  }

  Request _request(RequisitionApproveState state, String id) {
    return state.requisitions.firstWhere((element) => element.id == id);
  }

  String statusStepRequestApprove(RequisitionApproveState state) {
    Request request = _request(state, widget.id);
    String status = request.stepRequests
        ?.firstWhere((stepRequest) => stepRequest.status == EnumStepRequestStatusEnum.newStatus)
        .stepRequestApprovers
        ?.firstWhere((stepRequestApprovers) =>
    stepRequestApprovers.approverId == dI<UserBloc>().state.user.id).status
        ?.configStepRequestStatusName ?? "";
    return status;
  }


  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery
        .sizeOf(context)
        .height;
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) =>
          Container(
            height: _check(state, widget.id) ? height * 0.15 : height * 0.18,
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
                        statusStepRequestApprove(state),
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                      ),
                    ),
                  ),
                  if (_request(state, widget.id).status == StatusRequestEnum.approve)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ButtonItemListRequisition(
                        title: appLocalizations.cancel,
                        callback: () {},
                      ),
                    ),
                  if (_request(state, widget.id).status == StatusRequestEnum.process)
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
                      child: ContentItemRequisitionList(id: widget.id),
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
      'id': widget.id,
      'checkUser': true,
    });
  }


}
