import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_attach.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_general_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_sender_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_type.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/note/note_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionInformationPageRoute = GoRoute(
    path: Pages.requisitionInformationPage,
    name: Pages.requisitionInformationPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequisitionInformationPage(
        id: data['id'],
        checkUser: data['checkUser'],
      );
    });

class RequisitionInformationPage extends StatefulWidget {
  const RequisitionInformationPage({super.key, this.id = '', this.checkUser = false});

  final String id;
  final bool checkUser;

  @override
  State<RequisitionInformationPage> createState() => _RequisitionInformationPageState();
}

class _RequisitionInformationPageState extends State<RequisitionInformationPage> {
  String? note;

  @override
  void initState() {
    dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
    super.initState();
  }

  _listener(BuildContext context, RequisitionState state) {
    dI<FlowBloc>().add(GetFlowEvent(id: state.requisition.flowId));
    if (state.requisition.config.subtitudePersons?.isNotEmpty ?? false) {
      dI<UserByIdBloc>().add(
        GetSubtitudePersonsByIdEvent(
          ids: state.requisition.config.subtitudePersons ?? [],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocListener<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, state) => _listenerApprove(context, state),
      listenWhen: (previous, current) =>
          _listenApproveWhen(previous.statusApprove, current.statusApprove),
      child: BlocConsumer<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(context, state),
        buildWhen: (previous, current) => previous.requisition != current.requisition,
        listenWhen: (previous, current) => previous.requisition != current.requisition,
        builder: (context, state) {
          return BlocBuilder<FlowBloc, FlowState>(
            builder: (context, stateFlow) {
              return Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Column(
                      children: [
                        Text(stateFlow.flow.flowType?.configTypeName ?? "",
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                        Text('${appLocalizations.applicationCode} : ${state.requisition.code}',
                            style: TextStyle(
                                color: colors.surfaceVariantHigh, fontSize: SpacingUnit.x3)),
                      ],
                    ),
                  ),
                  actions: const [
                    SizedBox(
                      width: SpacingUnit.x15,
                    )
                  ],
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  decoration: BoxDecoration(
                    color: CustomsColor.colorBackground,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(SpacingUnit.x4),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const RequisitionInformationSenderInformation(),
                        RequisitionInformationGeneraliInformation(
                            followerIds: state.requisition.followerIds),
                        const RequisitionInformationType(),
                        const RequisitionInformationContent(),
                        const RequisitionInformationAttach(),
                        if (state.requisition.status == StatusRequestEnum.process &&
                            !widget.checkUser)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                              check: true,
                              title: appLocalizations.delete,
                              callback: () => userRejectRequest(),
                            ),
                          ),
                        if (state.requisition.status == StatusRequestEnum.edit && !widget.checkUser)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                              check: true,
                              title: appLocalizations.update,
                              callback: () =>
                                  _nextScreen(context, stateFlow.flow, state.requisition.id),
                            ),
                          ),
                        if (state.requisition.status == StatusRequestEnum.process &&
                            widget.checkUser)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonItemListRequisition(
                                title: appLocalizations.approver,
                                callback: () => _isApprover(
                                    state.requisition, context, EnumStepRequestStatusEnum.approve),
                              ),
                              ButtonItemListRequisition(
                                title: appLocalizations.refuse,
                                callback: () => _isApprover(
                                    state.requisition, context, EnumStepRequestStatusEnum.reject),
                              ),
                              ButtonItemListRequisition(
                                title: appLocalizations.modification,
                                callback: () => _isApprover(
                                    state.requisition, context, EnumStepRequestStatusEnum.edit),
                              ),
                            ],
                          ),
                        if (state.requisition.status == StatusRequestEnum.approve &&
                            widget.checkUser)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                              check: true,
                              title: appLocalizations.cancel,
                              callback: () {},
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  _isApprover(request, BuildContext context, EnumStepRequestStatusEnum status) {
    String idUser = dI<UserBloc>().state.user.id;
    if (request.stepRequests?.isNotEmpty ?? false) {
      final stepRequests = request.stepRequests ?? [];
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
    Navigator.of(context).pop();
    progressIndicatorDialog(context);
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
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
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

  _listenerApprove(BuildContext context, RequisitionApproveState state) {
    if (dI<AppNavigation>().isCurrentPage(Pages.requisitionInformationPage)) {
      if (state.statusApprove == RequisitionEnum.success) {
        successDialog(context);
        dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
      }
      if (state.statusApprove == RequisitionEnum.fail) {
        unsuccessfulDialog(context);
      }
    }
  }

  _listenApproveWhen(RequisitionEnum statusApproveP, RequisitionEnum statusApproveC) {
    return statusApproveP != statusApproveC;
  }

  _push({
    required BuildContext context,
    required String page,
    required String id,
    required String requestId,
  }) {
    dI<AppNavigation>().pushName(
      context,
      page: page,
      extra: {'flowId': id, 'requestId': requestId},
    );
  }

  _nextScreen(BuildContext context, FlowRequest flow, String requestId) {
    switch (flow.flowType) {
      case RequisitionTypeEnum.explanation:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestExplanationPage,
        );
      case RequisitionTypeEnum.lateArrival:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.overTime:
      /*_push(
          context: context,
          id: flow.id,
          page: Pages.createRequestLeavePage,
        );*/
      case RequisitionTypeEnum.vehicleDriver:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestVehicleDispatchPage,
        );
      case RequisitionTypeEnum.postalDelivery:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestPostalDeliveryPage,
        );
      case RequisitionTypeEnum.warehouseReleased:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestReleaseOfWarehousePage,
        );
      case RequisitionTypeEnum.stationery:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestStationeryOderPage,
        );
      case RequisitionTypeEnum.bussiness:
        _push(
          requestId: requestId,
          context: context,
          id: flow.id,
          page: Pages.createRequestBusinessPage,
        );
      default:
        break;
    }
  }
}
