import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/work_day_admin_query_params.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/cancel_work_day_request.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/calendar_work/register_shift_admin.dart/register_work_day_admin.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final registerWorkDayAdminDetailPageRoute = GoRoute(
    path: Pages.registerWorkDayAdminDetail,
    builder: (context, GoRouterState state) {
      if (state.uri.hasQuery) {
        final query = state.uri.queryParameters;
        final data = WorkDayAdminQueryParams.fromJson(query);
        return RegisterWorkDayAdminDetail(
          id: data.id,
          type: data.type,
          nameWorkShift: data.nameWorkShift,
          workDate: data.workDate,
        );
      }
      return const ErrorPage();
    });

class RegisterWorkDayAdminDetail extends StatefulWidget {
  final WorkShiftRequestStatus type;
  final String id;
  final String nameWorkShift;
  final String workDate;

  const RegisterWorkDayAdminDetail({
    super.key,
    required this.id,
    required this.type,
    required this.nameWorkShift,
    required this.workDate,
  });

  @override
  State<RegisterWorkDayAdminDetail> createState() =>
      _RegisterWorkDayAdminDetailState();
}

class _RegisterWorkDayAdminDetailState
    extends State<RegisterWorkDayAdminDetail> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  FlowStatusEnum status = FlowStatusEnum.init;
  WorkShiftRequestStatus selectType = WorkShiftRequestStatus.approve;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    dI<FlowBloc>().add(const GetFlowsEvent());
    final electiveShiftItems = dI<WorkDayBloc>().state.electiveShiftItems;
    /*[widget.workDayAdminIndex]
        .workShiftRegisteredDetails
        .first;*/
    if (widget.type == WorkShiftRequestStatus.approve ||
        widget.type == WorkShiftRequestStatus.usable) {
      final data = electiveShiftItems
          .where((element) =>
              element.workDate.toString() == widget.workDate &&
              element.nameWorkShift == widget.nameWorkShift)
          .toList();
      dI<WorkDayBloc>().add(
        GetElectiveShiftDetail(
          data: GetElectiveShiftDetailRequest(
            date: widget.workDate,
            isApprove: widget.type == WorkShiftRequestStatus.approve,
            workShiftSettingDetailIds:
                data.map((e) => e.workShiftSettingDetailId).toList(),
          ),
        ),
      );
    }
    super.initState();
  }

  _onClickCancel(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus status}) async {
    final Completer completer = Completer<bool>();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    setCheckLoad();
    dI<WorkDayBloc>().add(CancelRegisterWorkDayAdmin(
      data: CancelWorkDayAdminRequest(
        ids: [workShiftRequestId],
        note: textEditingController.text,
      ),
      completer: completer,
    ));
    final check = await completer.future;
    if (check) {
      dI<WorkDayBloc>().add(
        GetWorkDayAdmin(
          data: WorkDayAdminRequest(requestStatus: status),
        ),
      );
      if (!currentContext.mounted) return;
      _onBack();
      _onBack();
      _onBack();
      dialogSuccess(
          context: currentContext,
          title: mapByStatus(
                  status: status, context: currentContext)['rejectApprove'] ??
              "",
          isPop: false);
    } else {
      _onBack();
      _onBack();
    }
  }

  _onBack() {
    Navigator.of(context).pop();
  }

  _onCancel(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus status,
      String? name}) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SpacingUnit.x4),
              topRight: Radius.circular(SpacingUnit.x4),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mapByStatus(
                          status: status,
                          context: context,
                          name: name)['reject'] ??
                      "",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                TextField(
                  controller: textEditingController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.outline),
                    ),
                    suffixStyle: const TextStyle(color: Colors.green),
                    hintText: "${appLocalizations.reason}...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: SpacingUnit.x4, horizontal: SpacingUnit.x4),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _onClickCancel(
                              workShiftRequestId: workShiftRequestId,
                              status: status),
                          child: Container(
                            height: SpacingUnit.x12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x2),
                            ),
                            child: Center(
                              child: Text(
                                appLocalizations.reject,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: SpacingUnit.x3,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: SpacingUnit.x12,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: colors.outline.withOpacity(0.5),
                              ),
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x2),
                            ),
                            child: Center(
                              child: Text(appLocalizations.cancel,
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: SpacingUnit.x8,
          ),
        ),
        title: widget.type == WorkShiftRequestStatus.approve ||
                widget.type == WorkShiftRequestStatus.usable
            ? BlocBuilder<WorkDayBloc, WorkDayState>(
                builder: (context, state) {
                  final data = state.electiveShiftItems.firstWhere((element) =>
                      element.workShiftSettingDetailId == widget.id);
                  return Text(
                    data.nameWorkShift,
                    style: theme.textTheme.titleLarge,
                  );
                },
              )
            : null,
      ),
      body: _getBody(widget.type, context),
    );
  }

  _getBody(WorkShiftRequestStatus type, BuildContext context) {
    if (type == WorkShiftRequestStatus.approve ||
        type == WorkShiftRequestStatus.usable) {
      return _bodyApprover(context);
    } else if (type == WorkShiftRequestStatus.pending ||
        type == WorkShiftRequestStatus.pendingCancel) {
      return _bodyPending(context);
    }
  }

  _bodyPending(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final index = state.items
            .indexWhere((element) => element.workShiftApproveId == widget.id);
        final data = index != -1 ? state.items[index] : const WorkDayAdmin();
        return Column(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(SpacingUnit.x4),
              child: ListView(
                children: [
                  Text(data.nameWorkShift,
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: SpacingUnit.x4,
                  ),
                  ItemTitleValueNoBorder(
                    size: SpacingUnit.x4,
                    font: FontWeight.w600,
                    spaceBetween: false,
                    title: appLocalizations.time,
                    value:
                        '${strSeconds(data.startTime)} - ${strSeconds(data.endTime)} ${formatDMY(data.workDate.toString())}',
                  ),
                  LineWidget(color: colors.outline.withOpacity(0.8)),
                  ItemTitleValueNoBorder(
                    size: SpacingUnit.x4,
                    font: FontWeight.w600,
                    spaceBetween: false,
                    title: data.name,
                    value: '#${data.code}',
                  ),
                  ItemTitleValueNoBorder(
                    size: SpacingUnit.x4,
                    spaceBetween: false,
                    title: data.namePosition,
                    value: '#${data.code}',
                  ),
                  LineWidget(color: colors.outline.withOpacity(0.8)),
                  if (data.content.isNotEmpty) ...[
                    Text("${appLocalizations.reasonCancelShift}:",
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(
                      height: SpacingUnit.x2,
                    ),
                    Text(
                      data.content,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SpacingUnit.x4, horizontal: SpacingUnit.x4),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _onCancel(
                          workShiftRequestId: data.workShiftRequestId,
                          status: data.status),
                      child: Container(
                        height: SpacingUnit.x10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colors.outline.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                        ),
                        child: Center(
                          child: Text(
                            appLocalizations.reject,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x3,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _dialogConfirm(
                        context: context,
                        data: data,
                      ),
                      child: Container(
                        height: SpacingUnit.x10,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                        ),
                        child: Center(
                          child: Text(
                            appLocalizations.confirm,
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  _bodyApprover(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final index = state.electiveShiftItems.indexWhere(
            (element) => element.workShiftSettingDetailId == widget.id);
        final data = state.electiveShiftItems[index];
        return Column(
          children: [
            Text(
              "${appLocalizations.time}: ${strSeconds(data.startTime)} - ${strSeconds(data.endTime)} ${formatDMY(data.workDate.toString())}",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: SpacingUnit.x2),
            Expanded(
              child: Container(
                color: colors.surfaceVariantLow.withOpacity(0.1),
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: ListView.builder(
                  itemCount: state.itemsDetail.length,
                  itemBuilder: (context, index) => _Item(
                    state.itemsDetail[index],
                    widget.type,
                    onCancel: () {
                      _onCancel(
                          name: state.itemsDetail[index].name,
                          workShiftRequestId:
                              state.itemsDetail[index].workShiftRequestId,
                          status: state.itemsDetail[index].status);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _dialogConfirm({required BuildContext context, required WorkDayAdmin data}) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: DialogConfirm(
              title: data.status == WorkShiftRequestStatus.pending
                  ? appLocalizations.dialogConfirmContent
                  : appLocalizations.areYouSureCancelShift(data.name),
              onConfirm: () {
                _onBack();
                _approveRequestShift(data: data);
              }),
        );
      },
    );
  }

  ///-----------------------------------------
  _approveRequestShift({required WorkDayAdmin data}) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dI<WorkDayBloc>().add(
      AddApprove(
        completer: completer,
        request: ApproveRequest(
          status: data.status == WorkShiftRequestStatus.approve
              ? WorkShiftRequestStatus.reject
              : WorkShiftRequestStatus.approve,
          updateWorkShiftApproves: [
            UpdateWorkShiftApprovesRequest(
                id: data.workShiftApproveId, note: data.note)
          ],
        ),
      ),
    );
    final check = await completer.future;
    if (check) {
      dI<WorkDayBloc>().add(
        GetWorkDayAdmin(
          data: WorkDayAdminRequest(requestStatus: data.status),
        ),
      );
      if (!currentContext.mounted) return;
      _onBack();
      dialogSuccess(
          context: currentContext,
          title: mapByStatus(
                  status: data.status,
                  context: currentContext)['successApprove'] ??
              "",
          isPop: false);
    }
  }
}

class _Item extends StatelessWidget {
  final VoidCallback onCancel;
  final WorkShiftRequestStatus type;
  final WorkDayAdmin data;

  const _Item(this.data, this.type, {required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Container(
      margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
      padding: const EdgeInsets.all(SpacingUnit.x3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x3),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  "#${data.code}",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  data.namePosition,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          if (type == WorkShiftRequestStatus.approve)
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => onCancel.call(),
                child: Container(
                  height: SpacingUnit.x10,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colors.outline.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(SpacingUnit.x2),
                  ),
                  child: Center(
                    child: Text(
                      appLocalizations.remove2,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Map<String, dynamic> mapByStatus({
  required BuildContext context,
  required WorkShiftRequestStatus status,
  String? name,
}) {
  final colors = AppTheme.getColors(context);
  final appLocalizations = AppLocalizations.of(context)!;
  switch (status) {
    case WorkShiftRequestStatus.pending:
      return {
        'color': colors.error,
        'titleButton': appLocalizations.cancelShiftReceiveRegistration,
        'successApprove': appLocalizations.approveShiftSuccessfully,
        'rejectApprove': appLocalizations.refusedToRegisterASuccessfulShift,
        'reject': appLocalizations.rejectTitle2,
      };
    case WorkShiftRequestStatus.approve:
      return {
        'color': colors.error,
        'titleButton': appLocalizations.cancelShift1,
      };
    case WorkShiftRequestStatus.pendingCancel:
      return {
        'color': colors.error,
        'titleButton': appLocalizations.cancelShift2,
        'successApprove':
            appLocalizations.approveTheRequestToCancelTheShiftSuccessfully,
        'rejectApprove':
            appLocalizations.rejectTheRequestToCancelTheShiftSuccessfully,
        'reject': appLocalizations.rejectTitle1,
      };
    case WorkShiftRequestStatus.usable:
      return {
        'color': colors.blue,
        'titleButton': appLocalizations.registerForShifts,
        'success': appLocalizations.registeredShiftSuccessfully,
        'rejectApprove':
            appLocalizations.rejectTheRequestToCancelTheShiftSuccessfully,
        'reject': appLocalizations.rejectTitle1,
      };
    case WorkShiftRequestStatus.reject:
      return {
        'color': ColorUtils.parseHex('#2F6BFF'),
        'titleButton': appLocalizations.registerForShifts,
      };
    case WorkShiftRequestStatus.cancel:
      return {
        'color': ColorUtils.parseHex('#2F6BFF'),
        'titleButton': appLocalizations.registerForShifts,
        'success': appLocalizations.registeredShiftSuccessfully,
      };
    case WorkShiftRequestStatus.unusable:
      return {
        'rejectApprove': appLocalizations.removeEmployeeSuccessful,
        'success': appLocalizations.removeEmployeeSuccessful,
        'reject': appLocalizations.removeTheEmployeeShift(name ?? ""),
      };
    case WorkShiftRequestStatus.remove:
    default:
      return {};
  }
}
