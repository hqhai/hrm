import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/user_type.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/routers/query_params/work_day_admin_query_params.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/toast_utils.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final registerWorkDayPageRoute = GoRoute(
    path: Pages.registerWorkDayAdmin,
    name: Pages.registerWorkDayAdmin,
    builder: (context, GoRouterState state) {
      if (state.uri.hasQuery) {
        final query = state.uri.queryParameters;
        final data = ShiftsBuyUserQueryParams.fromJson(query);
        return RegisterWorkDayAdminPage(
          userType: data.type,
        );
      }
      return const ErrorPage();
    });

class RegisterWorkDayAdminPage extends StatefulWidget {
  final UserType userType;
  const RegisterWorkDayAdminPage({super.key, required this.userType});

  @override
  State<RegisterWorkDayAdminPage> createState() =>
      _RegisterWorkDayAdminPageState();
}

class _RegisterWorkDayAdminPageState extends State<RegisterWorkDayAdminPage> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  FlowStatusEnum status = FlowStatusEnum.init;
  WorkShiftRequestStatus selectType = WorkShiftRequestStatus.approve;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int days = 30;

  @override
  void initState() {
    if (widget.userType == UserType.user) {
      Completer completer = Completer();
      dI<WorkDayBloc>().add(GetWorkDayByUser(completer: completer));
    } else {
      dI<FlowBloc>().add(const GetFlowsEvent());
      controller = ScrollController()..addListener(_scrollListener);
      dI<WorkDayBloc>().add(GetElectiveShift(
          data: WorkDayGetElectiveShiftRequest(
        pageSize: days,
        isApprove: true,
        startDate: formatYYMMDD(
            DateTime.now().subtract(Duration(days: days)).toString()),
        endDate: formatYYMMDD(DateTime.now().toString()),
      )));
      _loadData();
    }

    super.initState();
  }

  _loadData() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          _loadShift(selectType);
        }
      }
    });
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        status == FlowStatusEnum.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<FlowBloc>().add(GetFlowsEvent(
        page: pageIndex,
      ));
    }
  }

  _onTapHeader(WorkShiftRequestStatus type) {
    if (widget.userType == UserType.manage) {
      setState(() {
        days = 30;
      });
      switch (type) {
        case WorkShiftRequestStatus.approve:
          dI<WorkDayBloc>().add(GetElectiveShift(
              data: WorkDayGetElectiveShiftRequest(
            isApprove: true,
            startDate: formatYYMMDD(
                DateTime.now().subtract(Duration(days: days)).toString()),
            endDate: formatYYMMDD(DateTime.now().toString()),
          )));
          break;
        case WorkShiftRequestStatus.unusable:
          dI<WorkDayBloc>().add(GetElectiveShift(
              data: WorkDayGetElectiveShiftRequest(
            isApprove: false,
            startDate: formatYYMMDD(
                DateTime.now().subtract(Duration(days: days)).toString()),
            endDate: formatYYMMDD(DateTime.now().toString()),
          )));
          break;
        case WorkShiftRequestStatus.pendingCancel:
          dI<WorkDayBloc>().add(const GetWorkDayAdmin(
              data: WorkDayAdminRequest(
                  requestStatus: WorkShiftRequestStatus.pendingCancel)));
          break;
        case WorkShiftRequestStatus.pending:
          dI<WorkDayBloc>().add(const GetWorkDayAdmin(
              data: WorkDayAdminRequest(
                  requestStatus: WorkShiftRequestStatus.pending)));
          break;
        default:
          () {};
      }
    }
  }

  _loadShift(WorkShiftRequestStatus type) {
    final pagingInfo = dI<WorkDayBloc>().state.pagingInfo;
    setState(() {
      days = days + 30;
    });
    switch (type) {
      case WorkShiftRequestStatus.approve:
        dI<WorkDayBloc>().add(GetElectiveShift(
            data: WorkDayGetElectiveShiftRequest(
          pageSize: days,
          isApprove: true,
          startDate: formatYYMMDD(
              DateTime.now().subtract(Duration(days: days)).toString()),
          endDate: formatYYMMDD(DateTime.now().toString()),
        )));
        break;
      case WorkShiftRequestStatus.unusable:
        dI<WorkDayBloc>().add(GetElectiveShift(
            data: WorkDayGetElectiveShiftRequest(
          pageSize: days,
          isApprove: false,
          startDate: formatYYMMDD(
              DateTime.now().subtract(Duration(days: days)).toString()),
          endDate: formatYYMMDD(DateTime.now().toString()),
        )));
        break;
      case WorkShiftRequestStatus.pendingCancel:
        dI<WorkDayBloc>().add(GetWorkDayAdmin(
            data: WorkDayAdminRequest(
                pageSize: pagingInfo.pageSize + 7,
                requestStatus: WorkShiftRequestStatus.pendingCancel)));
        break;
      case WorkShiftRequestStatus.pending:
        dI<WorkDayBloc>().add(GetWorkDayAdmin(
            data: WorkDayAdminRequest(
                pageSize: pagingInfo.pageSize + 7,
                requestStatus: WorkShiftRequestStatus.pending)));
        break;
      default:
        () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
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
        title: Text(
          widget.userType == UserType.manage
              ? appLocalizations.proactiveCaseRegistrationManagement
              : appLocalizations.shiftManagement,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocBuilder<WorkDayBloc, WorkDayState>(
        // listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: SpacingUnit.x15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: WorkShiftRequestStatus.values.length,
                  itemBuilder: (context, index) {
                    if (widget.userType == UserType.user) {
                      if (WorkShiftRequestStatus.values[index] ==
                              WorkShiftRequestStatus.unusable ||
                          WorkShiftRequestStatus.values[index] ==
                              WorkShiftRequestStatus.remove ||
                          WorkShiftRequestStatus.values[index] ==
                              WorkShiftRequestStatus.usable) {
                        return const SizedBox();
                      } else {
                        return InkWell(
                          onTap: () {
                            _onTapHeader(WorkShiftRequestStatus.values[index]);
                            setState(() {
                              selectType = WorkShiftRequestStatus.values[index];
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SpacingUnit.x4),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: const BorderSide(width: 0),
                                      bottom: selectType ==
                                              WorkShiftRequestStatus
                                                  .values[index]
                                          ? BorderSide(
                                              width: 3,
                                              color: ColorUtils.parseHex(
                                                  '#808890'))
                                          : const BorderSide(width: 0))),
                              child: Center(
                                  child: Row(
                                children: [
                                  Text(
                                    WorkShiftRequestStatus.values[index]
                                        .configWorkShiftRequestStatusName,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                            color: WorkShiftRequestStatus
                                                        .values[index] ==
                                                    selectType
                                                ? null
                                                : ColorUtils.parseHex(
                                                    "#B2B7BC")),
                                  ),
                                  if (WorkShiftRequestStatus.values[index] ==
                                      selectType) ...[
                                    const SizedBox(width: SpacingUnit.x2),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: SpacingUnit.x2,
                                            vertical: SpacingUnit.x1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              SpacingUnit.x3),
                                          color: ColorUtils.parseHex("#EAF0FF"),
                                        ),
                                        child: Text(
                                          state.items
                                              .where((element) =>
                                                  element.status == selectType)
                                              .length
                                              .toString(),
                                          style: theme.textTheme.titleSmall
                                              ?.copyWith(
                                                  color: ColorUtils.parseHex(
                                                      "#2F6BFF")),
                                        ))
                                  ]
                                ],
                              ))),
                        );
                      }
                    } else {
                      if (index < 4) {
                        return InkWell(
                          onTap: () {
                            _onTapHeader(WorkShiftRequestStatus.values[index]);
                            setState(() {
                              selectType = WorkShiftRequestStatus.values[index];
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: const BorderSide(width: 0),
                                      bottom: selectType ==
                                              WorkShiftRequestStatus
                                                  .values[index]
                                          ? BorderSide(
                                              width: 3,
                                              color: ColorUtils.parseHex(
                                                  '#808890'))
                                          : const BorderSide(width: 0))),
                              width: MediaQuery.sizeOf(context).width / 2.5,
                              child: Center(
                                  child: Text(
                                WorkShiftRequestStatus.values[index]
                                    .configWorkShiftRequestStatusName,
                                style: theme.textTheme.titleMedium,
                              ))),
                        );
                      }
                    }
                    return null;
                  },
                ),
              ),
              if (widget.userType == UserType.user) ...[
                Expanded(
                    child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  color: colors.surfaceVariantLow.withOpacity(0.1),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...state.items.map((e) {
                          if (e.status == selectType) {
                            return _ItemUser(
                              e,
                            );
                          } else {
                            return const SizedBox();
                          }
                        })
                      ],
                    ),
                  ),
                ))
              ] else ...[
                if (selectType == WorkShiftRequestStatus.pending ||
                    selectType == WorkShiftRequestStatus.pendingCancel)
                  _Search(status: selectType),
                if (selectType == WorkShiftRequestStatus.approve ||
                    selectType == WorkShiftRequestStatus.unusable) ...[
                  if (state.electiveShiftItems.isEmpty) Container(),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    color: colors.surfaceVariantLow.withOpacity(0.1),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.electiveShiftItems.length,
                      itemBuilder: (context, index) => _Item(
                          state.electiveShiftItems[
                              (state.electiveShiftItems.length - 1) - index],
                          index,
                          selectType),
                    ),
                  ))
                ] else ...[
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    color: colors.surfaceVariantLow.withOpacity(0.1),
                    child: ListView.builder(
                      itemCount: state.items.length,
                      controller: scrollController,
                      itemBuilder: (context, index) => _ItemPending(
                        state.items[index],
                        index,
                        selectType,
                        onConfirm: () => _openDialogConfirm(
                            workShiftRequestId:
                                state.items[index].workShiftApproveId,
                            type: selectType),
                        onReject: () => _onCancel(
                            workShiftRequestId:
                                state.items[index].workShiftApproveId,
                            type: selectType),
                      ),
                    ),
                  ))
                ],
              ],
            ],
          );
        },
      ),
    );
  }

  _onReject(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus type}) async {
    final appLocalizations = AppLocalizations.of(context)!;
    try {
      Completer completer = Completer<bool>();

      dI<WorkDayBloc>().add(RegisterWorkDayAdmin(
          request: ApproveRequest(
              status: WorkShiftRequestStatus.reject,
              updateWorkShiftApproves: [
                UpdateWorkShiftApprovesRequest(
                    id: workShiftRequestId, note: textEditingController.text)
              ]),
          completer: completer));
      final check = await completer.future;
      if (check) {
        _onTapHeader(type);
        ToastUtils().showSuccess(appLocalizations.success);
      } else {
        ToastUtils().showError(appLocalizations.unsuccessful);
      }
    } catch (e) {
      ToastUtils().showError(appLocalizations.unsuccessful);
    }
  }

  _onCancel(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus type}) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            height: 490,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SpacingUnit.x4),
                topRight: Radius.circular(SpacingUnit.x4),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    selectType == WorkShiftRequestStatus.pendingCancel
                        ? appLocalizations.rejectTitle1
                        : selectType == WorkShiftRequestStatus.pending
                            ? appLocalizations.rejectTitle2
                            : "",
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black)),
                TextField(
                  controller: textEditingController,
                  maxLines: 11,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.outline)),
                    suffixStyle: const TextStyle(color: Colors.green),
                    hintText: "Nhập lý do...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: SpacingUnit.x4, horizontal: SpacingUnit.x4),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _onReject(
                            workShiftRequestId: workShiftRequestId,
                            type: type,
                          ),
                          child: Container(
                            height: SpacingUnit.x12,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x2)),
                            child: Center(
                              child: Text(appLocalizations.reject,
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
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
                                    color: colors.outline.withOpacity(0.5)),
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x2)),
                            child: Center(
                              child: Text("Hủy",
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
          );
        });
  }

  _onConfirm(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus type}) async {
    final appLocalizations = AppLocalizations.of(context)!;
    Navigator.pop(context);
    try {
      Completer completer = Completer<bool>();
      dI<WorkDayBloc>().add(RegisterWorkDayAdmin(
          request: ApproveRequest(
              status: WorkShiftRequestStatus.approve,
              updateWorkShiftApproves: [
                UpdateWorkShiftApprovesRequest(
                    id: workShiftRequestId, note: textEditingController.text)
              ]),
          completer: completer));
      final check = await completer.future;
      if (check) {
        _onTapHeader(type);
        ToastUtils().showSuccess(appLocalizations.success);
      } else {
        ToastUtils().showError(appLocalizations.unsuccessful);
      }
    } catch (e) {
      ToastUtils().showError(appLocalizations.unsuccessful);
    }
  }

  _openDialogConfirm(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus type}) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogConfirm(
          onConfirm: () =>
              _onConfirm(workShiftRequestId: workShiftRequestId, type: type),
        );
      },
    );
  }
}

class _ItemUser extends StatelessWidget {
  final WorkDayAdmin data;
  const _ItemUser(this.data);

  @override
  Widget build(BuildContext context) {
    // final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => dI<AppNavigation>().push(context,
          page: Pages.shiftsPageReview,
          paramsQuerry: ShiftsReviewQueryParams(
            id: data.id,
          ).toJson()),
      child: Container(
        margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.name,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              const Icon(Icons.chevron_right)
            ]),
            const SizedBox(height: SpacingUnit.x3),
            Text(
                "Thời gian: ${strSeconds(data.startTime)} - ${strSeconds(data.endTime)} ${formatDMY(data.workDate.toString())}")
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final UsableAdmin data;
  final WorkShiftRequestStatus type;
  const _Item(this.data, this.index, this.type);

  @override
  Widget build(BuildContext context) {
    // final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry: WorkDayAdminQueryParams(
                  workDayAdminIndex: index.toString(), type: type)
              .toJson()),
      child: Container(
        margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.workShiftRegisteredDetails.first.nameWorkShift,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              const Icon(Icons.chevron_right)
            ]),
            const SizedBox(height: SpacingUnit.x3),
            Text(
                "Thời gian: ${strSeconds(data.workShiftRegisteredDetails.first.startTime)} - ${strSeconds(data.workShiftRegisteredDetails.first.endTime)} ${formatDMY(data.workDate.toString())}")
          ],
        ),
      ),
    );
  }
}

class _ItemPending extends StatelessWidget {
  final WorkDayAdmin data;
  final int index;
  final WorkShiftRequestStatus type;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  const _ItemPending(this.data, this.index, this.type,
      {required this.onConfirm, required this.onReject});

  _goDetail(context) {
    if (type == WorkShiftRequestStatus.approve ||
        type == WorkShiftRequestStatus.unusable) {
      dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry: WorkDayAdminQueryParams(
                  workDayAdminIndex: index.toString(), type: type)
              .toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => _goDetail(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.nameWorkShift,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              // Text(appLocalizations.seeDetails,
              //     style: theme.textTheme.bodySmall!.copyWith(
              //         fontWeight: FontWeight.w500, color: Colors.blue)),
            ]),
            const SizedBox(height: SpacingUnit.x3),
            Text("${data.name} #${data.code}"),
            Text(
                "${appLocalizations.time}: ${strSeconds(data.startTime)} - ${strSeconds(data.endTime)} ${formatDMY(data.workDate.toString())}"),
            const SizedBox(height: SpacingUnit.x4),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => onReject.call(),
                    child: Container(
                      height: SpacingUnit.x10,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: colors.outline.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(SpacingUnit.x2)),
                      child: Center(
                        child: Text(appLocalizations.reject,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: SpacingUnit.x3,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => onConfirm.call(),
                    child: Container(
                      height: SpacingUnit.x10,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(SpacingUnit.x2)),
                      child: Center(
                        child: Text("Xác nhận",
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Search extends StatefulWidget {
  final WorkShiftRequestStatus status;
  const _Search({required this.status});

  @override
  State<_Search> createState() => _SearchState();
}

class _SearchState extends State<_Search> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: SpacingUnit.x16,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x2),
        child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colors.outline, width: 0.5),
                borderRadius: BorderRadius.circular(SpacingUnit.x10),
              ),
              contentPadding: const EdgeInsets.only(top: 10),
              isDense: true,
              hintText: "Nhập tên",
              prefixIcon: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  dI<WorkDayBloc>().add(GetWorkDayAdmin(
                      data: WorkDayAdminRequest(
                          requestStatus: widget.status,
                          name: _textEditingController.text)));
                },
                child: const Icon(
                  Icons.search,
                  size: SpacingUnit.x8,
                  color: Colors.black,
                ),
              ),
            )),
      ),
    );
  }
}

class DialogConfirm extends StatelessWidget {
  final VoidCallback onConfirm;
  const DialogConfirm({super.key, required this.onConfirm});

  _onClose(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x4),
          color: colors.background,
        ),
        height: MediaQuery.sizeOf(context).height / 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _onClose(context);
              },
              child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.topRight,
                  child: const Icon(Icons.close)),
            ),
            const SizedBox(height: SpacingUnit.x3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x10),
              child: Text(
                appLocalizations.dialogConfirmContent,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
            AppButton(
              title: appLocalizations.confirm,
              onSubmit: () => onConfirm.call(),
            )
          ],
        ),
      ),
    );
  }
}
