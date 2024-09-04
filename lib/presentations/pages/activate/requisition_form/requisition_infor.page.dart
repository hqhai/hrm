import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/navigator_extra/information_request_extra.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/item_request_process.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_followes_information_request.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_attach.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_general_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_sender_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_type.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
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
  const RequisitionInformationPage({super.key, this.id = '', required this.checkUser});

  final String id;

  ///Đối tượng đang xem là người dùng, người duyệt hay người theo dõi
  final RequestSeeByWho checkUser;

  @override
  State<RequisitionInformationPage> createState() => _RequisitionInformationPageState();
}

class _RequisitionInformationPageState extends State<RequisitionInformationPage> {
  String? note;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  String errorDialog = '', errorDialogRevoke = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocListener<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, stateApprover) => listener(stateApprover.errorCode, context),
      child: BlocConsumer<RequisitionBloc, RequisitionState>(
        listener: (context, state) => listenerMyRequest(state.errorCode, context),
        buildWhen: (previous, current) => previous.requisition != current.requisition,
        builder: (context, state) {
          return BlocBuilder<FlowBloc, FlowState>(
            builder: (context, stateFlow) {
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: colors.text),
                  centerTitle: true,
                  title: Text(stateFlow.flow.flowType?.configTypeName ?? "",
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                  actions: const [
                    SizedBox(width: SpacingUnit.x15),
                  ],
                ),
                body: ContainerBorder(
                  backgroundColors: colors.background,
                  borderColors: colors.background,
                  marginTop: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.checkUser != RequestSeeByWho.user)
                          const RequisitionInformationSenderInformation(),
                        const RequisitionInformationGeneraliInformation(),
                        const RequisitionInformationType(),
                        if (state.requisition.flowType != RequisitionTypeEnum.stationery &&
                            state.requisition.flowType != RequisitionTypeEnum.makeUpWork)
                          const RequisitionInformationContent(),
                        if (state.requisition.config.attachments.isNotEmpty)
                          const RequisitionInformationAttach(),
                        const ItemFollowersInformationRequest(),
                        const ItemListStepFlow(
                          create: false,
                        ),
                        if (state.requisition.status == StatusRequestEnum.process &&
                            widget.checkUser == RequestSeeByWho.user)
                          ButtonItemListRequisition(
                            colorText: colors.error,
                            background: colors.error.withOpacity(0.2),
                            check: true,
                            title: appLocalizations.revoke,
                            callback: () => rejectDialog(context),
                          ),
                        if (state.requisition.status == StatusRequestEnum.edit &&
                            widget.checkUser == RequestSeeByWho.user)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ButtonItemListRequisition(
                                  colorText: colors.tertiary,
                                  background: colors.tertiary.withOpacity(0.2),
                                  check: true,
                                  title: appLocalizations.update,
                                  callback: () =>
                                      _nextScreen(stateFlow.flow, state.requisition),
                                ),
                              ),
                              const SizedBox(width: SpacingUnit.x4),
                              Expanded(
                                child: ButtonItemListRequisition(
                                  colorText: colors.error,
                                  background: colors.error.withOpacity(0.2),
                                  check: true,
                                  title: appLocalizations.revoke,
                                  callback: () => rejectDialog(context),
                                ),
                              ),
                            ],
                          ),
                        if (statusApprove(state.requisition) ==
                                EnumStepRequestStatusEnum.newStatus &&
                            widget.checkUser == RequestSeeByWho.manager)
                          ItemRequestProcess(
                            callBackApprover: () => _isApprover(
                                state.requisition, context, EnumStepRequestStatusEnum.approve),
                            callBackEdit: () => _isApprover(
                                state.requisition, context, EnumStepRequestStatusEnum.edit),
                            callBackReject: () => _isApprover(
                                state.requisition, context, EnumStepRequestStatusEnum.reject),
                          ),
                        if (checkFirstStepApprove(state.requisition) &&
                            widget.checkUser == RequestSeeByWho.manager)
                          ButtonItemListRequisition(
                            colorText: colors.error,
                            background: colors.error.withOpacity(0.2),
                            check: true,
                            title: appLocalizations.cancel,
                            callback: () => cancelRequest(context: context),
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

  bool checkFirstStepApprove(Request request) {
    if (request.status == StatusRequestEnum.approve) {
      final id = dI<UserBloc>().state.user.id;
      final stepRequests = request.stepRequests
          .where((element) => element.status == EnumStepRequestStatusEnum.approve)
          .toList();
      if (stepRequests != []) {
        stepRequests.sort((a, b) {
          int dateComparison = a.createdDate?.microsecondsSinceEpoch ??
              0.compareTo(b.createdDate?.microsecondsSinceEpoch ?? 0);
          return dateComparison;
        });
        final stepRequestApprovers = stepRequests.first.stepRequestApprovers;
        if (stepRequestApprovers != []) {
          final checkId = stepRequestApprovers!.first.approverId == id;
          return checkId;
        }
        return false;
      }
      return false;
    }
    return false;
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
    final appLocalizations = AppLocalizations.of(context)!;
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
    setCheckLoad();
    Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(
      UserRejectRequestEvent(
        id: widget.id,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter) {
      dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
      approverSuccess(title: appLocalizations.revokeRequestSuccess);
    } else {
      approverUnsuccessful(
          errorDialog: errorDialogRevoke, title: appLocalizations.revokeRequestUnsuccessful);
    }
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  cancelDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TitleCallbackDialog(
            title: appLocalizations.doYouWantRevokeYourRequest,
            callback: () => cancelRequest(context: context),
          ),
        );
      },
    );
  }

  cancelRequest({required BuildContext context}) async {
    final appLocalizations = AppLocalizations.of(context)!;
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
    setCheckLoad();
    final Completer completer = Completer<bool>();
    dI<RequisitionApproveBloc>().add(
      CancelRequestEvent(
        requestId: widget.id,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == true) {
      dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
      approverSuccess(title: appLocalizations.revokeRequestSuccess);
    }
    if (statusCompleter == false) {
      approverUnsuccessful(
          errorDialog: errorDialog, title: appLocalizations.revokeRequestUnsuccessful);
    }
  }

  _setApprove(String id, EnumStepRequestStatusEnum status, BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
    setCheckLoad();
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
      approverSuccess();
    }
    if (statusCompleter == false) {
      approverUnsuccessful(
        errorDialog: errorDialog,
      );
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

  listener(String errorCode, BuildContext context) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? setErrorValue(errorCode, context) ?? errorCode : "";
    });
  }

  listenerMyRequest(String errorCode, BuildContext context) {
    setState(() {
      errorDialogRevoke =
          errorCode.isNotEmpty ? setErrorValue(errorCode, context) ?? errorCode : "";
    });
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

  _nextScreen(FlowRequest flow, Request request) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final check = await checkLoadScreen(flow, request);
    if (check) {
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
        case RequisitionTypeEnum.makeUpWork:
          _push(
            type: RequisitionTypeEnum.makeUpWork,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
            ),
            context: currentContext,
            page: Pages.createRequestMakeUpWorkPage,
          );
        default:
          break;
      }
    }
  }

  Future<bool> loadFlow(FlowRequest flow) async {
    final Completer completer = Completer<bool>();
    dI<FlowBloc>().add(
      GetFlowEvent(
        id: flow.id,
        completer: completer,
      ),
    );
    return await completer.future;
  }

  Future<bool> loadWorkAndSalary() async {
    final Completer completer = Completer<bool>();
    dI<WorkAndSalaryBloc>().add(
      GetTotalLeaveDayEvent(
        completer: completer,
      ),
    );
    return await completer.future;
  }

  Future<bool> loadWorkShiftLeave(Request request) async {
    final Completer completer = Completer<bool>();
    dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: request.config.endDate ?? DateTime.now(),
        startDate: request.config.startDate ?? DateTime.now(),
        completer: completer));
    return await completer.future;
  }

  Future<bool> loadWorkShiftOneDay(Request request) async {
    final Completer completer = Completer<bool>();
    final date = request.config.workShiftSettings.first.workDate;
    dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: date,
        startDate: date,
        completer: completer));
    return await completer.future;
  }

  Future<bool> checkLoadScreen(FlowRequest flow, Request request) async {
    switch (flow.flowType) {
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        final checkF = await loadFlow(flow);
        final checkWAS = await loadWorkAndSalary();
        final checkWS = await loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS;
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        final checkF = await loadFlow(flow);
        final checkWAS = await loadWorkAndSalary();
        final checkWS = await loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS;
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        final checkF = await loadFlow(flow);
        final checkWAS = await loadWorkAndSalary();
        final checkWS = await loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS;
      case RequisitionTypeEnum.bussiness:
        final checkF = await loadFlow(flow);
        final checkWS = await loadWorkShiftLeave(request);
        return checkF && checkWS;
      case RequisitionTypeEnum.lateOrEarly:
        final checkF = await loadFlow(flow);
        final checkWS = await loadWorkShiftOneDay(request);
        return checkF && checkWS;
      case RequisitionTypeEnum.overTime:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.vehicleDriver:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.warehouseReleased:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.stationery:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.explanation:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.makeUpWork:
        final checkF = await loadFlow(flow);
        final checkWS = await loadWorkShiftOneDay(request);
        return checkF && checkWS;
      case RequisitionTypeEnum.postalDelivery:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.core:
        final checkF = await loadFlow(flow);
        return checkF;
      case RequisitionTypeEnum.unknown:
        return false;
      case null:
        return false;
    }
  }
}
