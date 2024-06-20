import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/content_item_requisition_list.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/note/note_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionApproveList extends StatefulWidget {
  final String id;
  final EnumStepRequestStatusEnum status;

  const ItemRequisitionApproveList({
    super.key,
    this.id = '',
    this.status = EnumStepRequestStatusEnum.newStatus,
  });

  @override
  State<ItemRequisitionApproveList> createState() => _ItemRequisitionApproveListState();
}

class _ItemRequisitionApproveListState extends State<ItemRequisitionApproveList> {

  String? note;
  @override
  void initState() {
    super.initState();
  }

  bool _check(RequisitionApproveState state, String id) {
    final requisitions = state.requisitions.firstWhere((element) => element.id == id);
    return requisitions.status != StatusRequestEnum.approve &&
        requisitions.status != StatusRequestEnum.process;
  }

  Request _request(List<Request> requests, String id) {
    return requests.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) => Container(
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
                    widget.status.configStepRequestStatusName,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                  ),
                ),
              ),
              if (widget.status.configStepRequestStatusName ==
                  EnumStepRequestStatusEnum.approve.configStepRequestStatusName)
                Align(
                  alignment: Alignment.bottomRight,
                  child: ButtonItemListRequisition(
                    title: appLocalizations.cancel,
                    callback: () {},
                  ),
                ),
              if (widget.status.configStepRequestStatusName ==
                  EnumStepRequestStatusEnum.newStatus.configStepRequestStatusName)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonItemListRequisition(
                        title: appLocalizations.approver,
                        callback: () => _isApprover(
                            state.requisitions, context, EnumStepRequestStatusEnum.approve),
                      ),
                      ButtonItemListRequisition(
                        title: appLocalizations.refuse,
                        callback: () => _isApprover(
                            state.requisitions, context, EnumStepRequestStatusEnum.reject),
                      ),
                      ButtonItemListRequisition(
                        title: appLocalizations.modification,
                        callback: () => _isApprover(
                            state.requisitions, context, EnumStepRequestStatusEnum.edit),
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

  _isApprover(List<Request> requests, BuildContext context, EnumStepRequestStatusEnum status) {
    String idUser = dI<UserBloc>().state.user.id;
    Request request = _request(requests, widget.id);
    if (request.stepRequests.isNotEmpty) {
      final stepRequests = request.stepRequests;
      final indexNewStepRequest = stepRequests
          .indexWhere((element) => element.status == EnumStepRequestStatusEnum.newStatus);
      if (indexNewStepRequest != -1) {
        final stepRequest = stepRequests[indexNewStepRequest];
        final stepRequestApproves = stepRequest.stepRequestApprovers ?? [];
        final int indexNewRequest =
            stepRequestApproves.indexWhere((element) => element.approverId == idUser);
        if (indexNewRequest != -1) {
          String idStepRequestApprove = stepRequestApproves[indexNewRequest].id;
          noteDialog(
            context,
                (value) => _setNote(value),
                () => _setApprove(idStepRequestApprove, status),
          );
        }
      }
    }
  }

  userRejectRequest() {
    dI<RequisitionBloc>().add(UserRejectRequestEvent(id: widget.id));
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  _setApprove(String id, EnumStepRequestStatusEnum status) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    Navigator.of(currentContext).pop();
    progressIndicatorDialog(currentContext);
    final Completer completer = Completer<RequisitionEnum>();
    dI<RequisitionApproveBloc>().add(
      ApproveRequestEvent(
        id: id,
        note: note,
        status: status,
        requestId: widget.id,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == RequisitionEnum.success) {
      if (!currentContext.mounted) return;
      Navigator.of(currentContext).pop();
      successDialog(currentContext);
    }
    if (statusCompleter == RequisitionEnum.fail) {
      if (!currentContext.mounted) return;
      Navigator.of(currentContext).pop();
      unsuccessfulDialog(currentContext);
    }
  }
}
