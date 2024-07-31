import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/navigator_extra/information_request_extra.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/item_request_process.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_attach.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_general_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_sender_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_type.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title_callback.dart';
import 'package:base_app/presentations/widgets/dialog/note/note_dialog.dart';
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
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      buildWhen: (previous, current) => previous.requisition != current.requisition,
      builder: (context, state) {
        return BlocBuilder<FlowBloc, FlowState>(
          builder: (context, stateFlow) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: colors.text),
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
                  SizedBox(width: SpacingUnit.x15),
                ],
              ),
              body: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                    margin: const EdgeInsets.symmetric(
                        horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(SpacingUnit.x4),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const RequisitionInformationSenderInformation(),
                          RequisitionInformationGeneraliInformation(checkUser: widget.checkUser),
                          const RequisitionInformationType(),
                          const RequisitionInformationContent(),
                          const RequisitionInformationAttach(),
                          const ItemListStepFlow(
                            create: false,
                          ),
                          if (state.requisition.status == StatusRequestEnum.process &&
                              !widget.checkUser)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ButtonItemListRequisition(
                                check: true,
                                title: appLocalizations.revoke,
                                callback: () => rejectDialog(context),
                              ),
                            ),
                          if (state.requisition.status == StatusRequestEnum.edit &&
                              !widget.checkUser)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ButtonItemListRequisition(
                                check: true,
                                title: appLocalizations.update,
                                callback: () => _nextScreen(stateFlow.flow),
                              ),
                            ),
                          if (statusApprove(state.requisition) ==
                                  EnumStepRequestStatusEnum.newStatus &&
                              widget.checkUser)
                            ItemRequestProcess(
                              callBackApprover: () => _isApprover(
                                  state.requisition, context, EnumStepRequestStatusEnum.approve),
                              callBackEdit: () => _isApprover(
                                  state.requisition, context, EnumStepRequestStatusEnum.edit),
                              callBackReject: () => _isApprover(
                                  state.requisition, context, EnumStepRequestStatusEnum.reject),
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
                  CheckLoadDialog(
                    checkLoad: checkLoad,
                    checkSuccess: checkSuccess,
                    checkUnSuccess: checkUnSuccess,
                    checkSuccessChange: () => setCheckSuccess(),
                    checkUnSuccessChange: () => setCheckUnSuccess(),
                  )
                ],
              ),
            );
          },
        );
      },
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
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: NoteDialog(
                    noteChange: (value) => _setNote(value),
                    callback: () => _setApprove(idStepRequestApprove, status, context),
                    status: status),
              );
            },
          );
        }
      }
    }
  }

  EnumStepRequestStatusEnum? statusApprove(Request request) {
    String idUser = dI<UserBloc>().state.user.id;
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
          EnumStepRequestStatusEnum? statusStepRequestApprove =
              stepRequestApproves[indexNewRequest].status;
          return statusStepRequestApprove;
        }
      }
    }
    return null;
  }

  rejectDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TitleCallbackDialog(
            title: appLocalizations.doYouWantRevokeYourRequest,
            callback: () => userRejectRequest(),
          ),
        );
      },
    );
  }

  userRejectRequest() async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
    setState(() {
      checkLoad = true;
    });
    Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(
      UserRejectRequestEvent(
        id: widget.id,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter) {
      setState(() {
        dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
        checkLoad = false;
        checkSuccess = true;
      });
    } else {
      setState(() {
        checkLoad = false;
        checkUnSuccess = true;
      });
    }
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  _setApprove(String id, EnumStepRequestStatusEnum status, BuildContext context) async {
    setState(() {
      checkLoad = true;
    });
    final Completer completer = Completer<bool>();
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
    if (statusCompleter == true) {
      dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
      setState(() {
        checkLoad = false;
        checkSuccess = true;
      });
    }
    if (statusCompleter == false) {
      setState(() {
        checkLoad = false;
        checkUnSuccess = true;
      });
    }
  }

  _push({
    RequisitionTypeEnum? type,
    required BuildContext context,
    required String page,
    required InformationRequestExtra informationRequestExtra,
  }) {
    final extraData = informationRequestExtra.toJson();
    if (type != null) {
      extraData.addAll({'type': type});
      dI<AppNavigation>().pushName(context, page: page, extra: extraData);
    } else {
      dI<AppNavigation>().pushName(
        context,
        page: page,
        extra: extraData,
      );
    }
  }

  _nextScreen(FlowRequest flow) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      if (!currentContext.mounted) return;
      switch (flow.flowType) {
        case RequisitionTypeEnum.explanation:
          _push(
            type: RequisitionTypeEnum.explanation,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestExplanationPage,
          );
        case RequisitionTypeEnum.lateOrEarly:
          _push(
            type: RequisitionTypeEnum.lateOrEarly,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestLateAndEarlyPage,
          );
        case RequisitionTypeEnum.overTime:
          _push(
            type: RequisitionTypeEnum.overTime,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestOverTimePage,
          );
        case RequisitionTypeEnum.vehicleDriver:
          _push(
            type: RequisitionTypeEnum.vehicleDriver,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestVehicleDispatchPage,
          );
        case RequisitionTypeEnum.postalDelivery:
          _push(
            type: RequisitionTypeEnum.postalDelivery,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestPostalDeliveryPage,
          );
        case RequisitionTypeEnum.warehouseReleased:
          _push(
            type: RequisitionTypeEnum.warehouseReleased,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestReleaseOfWarehousePage,
          );
        case RequisitionTypeEnum.stationery:
          _push(
            type: RequisitionTypeEnum.stationery,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestStationeryOderPage,
          );
        case RequisitionTypeEnum.bussiness:
          _push(
            type: RequisitionTypeEnum.bussiness,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestBusinessPage,
          );
        case RequisitionTypeEnum.leaveFiveDaysOrMore:
          _push(
            type: RequisitionTypeEnum.leaveFiveDaysOrMore,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestLeavePage,
          );
        case RequisitionTypeEnum.leaveTwoDayToFourDay:
          _push(
            type: RequisitionTypeEnum.leaveTwoDayToFourDay,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestLeavePage,
          );
        case RequisitionTypeEnum.leaveHalfDayToOneDay:
          _push(
            type: RequisitionTypeEnum.leaveHalfDayToOneDay,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestLeavePage,
          );
        default:
          break;
    }
  }

  setCheckSuccess() {
    setState(() {
      checkSuccess = false;
    });
  }

  setCheckUnSuccess() {
    setState(() {
      checkUnSuccess = false;
    });
  }
}
