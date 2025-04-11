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
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/content_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/content_requisition_expand.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/dialog_requisition_over_time.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/requisition_over_time_widget.dart';
import 'package:base_app/presentations/widgets/custom/app_icon_status.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title_callback.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemMyRequisitionList extends StatefulWidget {
  const ContentItemMyRequisitionList({
    super.key,
    required this.id,
    required this.self,
  });

  final String id;

  ///Có phải đơn của mình không
  final RequestSeeByWho self;

  @override
  State<ContentItemMyRequisitionList> createState() =>
      _ContentItemMyRequisitionListState();
}

class _ContentItemMyRequisitionListState
    extends State<ContentItemMyRequisitionList> {
  String errorDialog = '', errorDialogRevoke = '';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (BuildContext context, RequisitionState state) => _listener(
        context: context,
        errorCode: state.errorCode,
      ),
      builder: (context, state) {
        final request = state.requisitions[widget.id] ?? const Request(id: '');
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.flowType.configTypeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.text,
                  size: SpacingUnit.x6,
                ),
              ],
            ),
            (request.status != StatusRequestEnum.reject &&
                    request.status != StatusRequestEnum.edit &&
                    request.status != StatusRequestEnum.cancel)
                ? ContentRequisition(request: request)
                : ContentRequisitionExpand(
                    request: request,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: SpacingUnit.x2_5),
              child: AppIconStatus(
                color: statusRequest(
                    context: context, status: request.status)['color'],
                icon: statusRequest(
                    context: context, status: request.status)['icon'],
                status: request.status.getRequestStatusNameSeft,
              ),
            ),
            request.config.overTimes != null
                ? RequisitionOverTimeBody(
                    data: request.config.overTimes!,
                    onShowDialog: () {
                      showCustomDialog(
                        context: context,
                        data: request.config.overTimes,
                        onCancel: _cancelPop,
                      );
                    },
                    // onCancel: _cancelPop(context),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            request.status == StatusRequestEnum.edit
                ? Column(
                    children: [
                      const SizedBox(height: SpacingUnit.x4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ButtonItemListRequisition(
                              colorText: colors.tertiary,
                              background:
                                  colors.tertiary.withValues(alpha: 0.2),
                              check: false,
                              title: appLocalizations.update,
                              callback: () => _nextScreen(
                                flow: request.flow ?? const FlowRequest(id: ''),
                                request: request,
                              ),
                            ),
                          ),
                          const SizedBox(width: SpacingUnit.x4),
                          Expanded(
                            child: ButtonItemListRequisition(
                              colorText: colors.error,
                              background: colors.error.withValues(alpha: 0.2),
                              check: false,
                              title: appLocalizations.revoke,
                              callback: () => _rejectDialog(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  _nextScreen({
    required FlowRequest flow,
    required Request request,
  }) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dialogIndicator(context: currentContext);
    final check = await checkLoadScreen(flow, request);
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      switch (flow.flowType) {
        case RequisitionTypeEnum.explanation:
          _push(
            type: RequisitionTypeEnum.explanation,
            informationRequestExtra: InformationRequestExtra(
              requestId: widget.id,
              flowId: flow.id,
              date: DateTime.now(),
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

  Future<bool> checkLoadScreen(FlowRequest flow, Request request) async {
    switch (flow.flowType) {
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWAS = await _loadWorkAndSalary();
        final checkWS = await _loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS && checkRequest;
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWAS = await _loadWorkAndSalary();
        final checkWS = await _loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS && checkRequest;
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWAS = await _loadWorkAndSalary();
        final checkWS = await _loadWorkShiftLeave(request);
        return checkF && checkWAS && checkWS && checkRequest;
      case RequisitionTypeEnum.bussiness:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWS = await _loadWorkShiftLeave(request);
        return checkF && checkWS && checkRequest;
      case RequisitionTypeEnum.lateOrEarly:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWS = await _loadWorkShiftOneDay(request);
        return checkF && checkWS && checkRequest;
      case RequisitionTypeEnum.overTime:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.vehicleDriver:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.warehouseReleased:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.stationery:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.explanation:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.makeUpWork:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        final checkWS = await _loadWorkShiftOneDay(request);
        return checkF && checkWS && checkRequest;
      case RequisitionTypeEnum.postalDelivery:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      case RequisitionTypeEnum.core:
        final checkRequest = await _loadRequestById(request.id);
        final checkF = await _loadFlow(flow);
        return checkF && checkRequest;
      default:
        return false;
    }
  }

  Future<bool> _loadRequestById(String id) async {
    final Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(
      GetRequisitionByIdEvent(id: id, completer: completer),
    );
    final completerCheck = await completer.future;
    return completerCheck;
  }

  Future<bool> _loadFlow(FlowRequest flow) async {
    final Completer completer = Completer<bool>();
    dI<FlowBloc>().add(
      GetFlowEvent(
        id: flow.id,
        completer: completer,
      ),
    );
    return await completer.future;
  }

  Future<bool> _loadWorkAndSalary() async {
    final Completer completer = Completer<bool>();
    dI<WorkAndSalaryBloc>().add(
      GetTotalLeaveTypeEvent(
        completer: completer,
      ),
    );
    return await completer.future;
  }

  Future<bool> _loadWorkShiftLeave(Request request) async {
    final Completer completer = Completer<bool>();
    dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: request.config.endDate ?? DateTime.now(),
        startDate: request.config.startDate ?? DateTime.now(),
        completer: completer));
    return await completer.future;
  }

  Future<bool> _loadWorkShiftOneDay(Request request) async {
    final Completer completer = Completer<bool>();
    final date = request.config.workShiftSettings.first.workDate;
    dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: date, startDate: date, completer: completer));
    return await completer.future;
  }

  _listener({
    required String errorCode,
    required BuildContext context,
  }) {
    setState(() {
      errorDialog = errorCode.isNotEmpty
          ? setErrorValue(errorCode, context) ?? errorCode
          : "";
    });
  }

  _rejectDialog(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TitleCallbackDialog(
            title: appLocalizations.doYouWantRevokeYourRequest,
            callback: () => _userRejectRequest(),
          ),
        );
      },
    );
  }

  _userRejectRequest() async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
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
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      approverUnsuccessful(
          errorDialog: errorDialogRevoke,
          title: appLocalizations.revokeRequestUnsuccessful);
    }
  }

  Map<String, dynamic> statusRequest(
      {required BuildContext context, required StatusRequestEnum status}) {
    final colors = AppTheme.getColors(context);
    switch (status) {
      case StatusRequestEnum.process:
        return {
          'color': colors.goldenPurple,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.reject:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case StatusRequestEnum.edit:
        return {
          'color': colors.secondary.withValues(alpha: 0.7),
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.approve:
        return {
          'color': colors.success,
          'icon': Assets.images.icon.work.success,
        };
      case StatusRequestEnum.cancel:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case StatusRequestEnum.overdueEdit:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
      case StatusRequestEnum.overdueApprove:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
      default:
        return {};
    }
  }
}

_cancelPop() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext;
  dI<AppNavigation>().pop(currentContext);
}
