import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/type_filter_work_shift.dart';
import 'package:base_app/common/enum/user_type.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/routers/query_params/work_day_admin_query_params.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/time_utils.dart';
import 'package:base_app/common/utils/toast_utils.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/widgets/calendar_work/filter_date_time.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  FlowStatusEnum status = FlowStatusEnum.init;
  DateTime startTime = getFirstDayOfMonth(DateTime.now()),
      endTime = getLastDayOfMonth(DateTime.now());
  WorkShiftRequestStatus selectType = WorkShiftRequestStatus.approve;
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int days = 30;
  bool isLoading = false;
  FilterType filterType = FilterType.no;

  @override
  void initState() {
    if (widget.userType == UserType.user) {
      Completer completer = Completer();
      dI<WorkDayBloc>().add(
        GetWorkDayByUser(
          completer: completer,
          request: WorkDayGetElectiveShiftRequest(
              startDate: startTime, endDate: endTime, pageSize: days, page: 1),
        ),
      );
    } else {
      setState(() {
        selectType = WorkShiftRequestStatus.pending;
      });

      dI<WorkDayBloc>().add(
        const GetWorkDayAdmin(
          data: WorkDayAdminRequest(
            requestStatus: WorkShiftRequestStatus.pending,
            name: '',
          ),
        ),
      );

      dI<WorkDayBloc>().add(
        const GetWorkDayAdmin(
          data: WorkDayAdminRequest(
            requestStatus: WorkShiftRequestStatus.pendingCancel,
            name: '',
          ),
        ),
      );
      _loadData();
    }
    super.initState();
  }

  _loadData() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          _loadShift(type: selectType, isUnScroll: false);
        }
      }
    });
  }

  _onTapHeader(WorkShiftRequestStatus type) async {
    if (widget.userType == UserType.manage) {
      setState(() {
        days = 30;
      });
      setState(() {
        isLoading = true;
      });
      final Completer completer = Completer<bool>();
      switch (type) {
        case WorkShiftRequestStatus.approve:
          dI<WorkDayBloc>().add(
            GetElectiveShift(
              completer: completer,
              data: WorkDayGetElectiveShiftRequest(
                isApprove: true,
                startDate: startTime,
                endDate: endTime,
              ),
            ),
          );
          await completer.future;
          setState(() {
            isLoading = false;
          });
          break;
        case WorkShiftRequestStatus.usable:
          dI<WorkDayBloc>().add(
            GetElectiveShift(
              completer: completer,
              data: WorkDayGetElectiveShiftRequest(
                isApprove: false,
                startDate: startTime,
                endDate: endTime,
              ),
            ),
          );
          await completer.future;
          setState(() {
            isLoading = false;
          });
          break;
        case WorkShiftRequestStatus.pendingCancel:
          dI<WorkDayBloc>().add(GetWorkDayAdmin(
              completer: completer,
              data: const WorkDayAdminRequest(
                  requestStatus: WorkShiftRequestStatus.pendingCancel)));
          await completer.future;
          setState(() {
            isLoading = false;
          });
          break;
        case WorkShiftRequestStatus.pending:
          dI<WorkDayBloc>().add(GetWorkDayAdmin(
              completer: completer,
              data: const WorkDayAdminRequest(
                  requestStatus: WorkShiftRequestStatus.pending)));
          await completer.future;
          setState(() {
            isLoading = false;
          });
          break;
        default:
          () {};
      }
    }
  }

  _loadShift(
      {required WorkShiftRequestStatus type, bool isUnScroll = false}) async {
    final pagingInfo = dI<WorkDayBloc>().state.pagingInfo;
    if (!isUnScroll) {
      setState(() {
        days = days + 30;
      });
    }
    if (isUnScroll) {
      setState(() {
        isLoading = true;
      });
    }
    final Completer completer = Completer<bool>();
    switch (type) {
      case WorkShiftRequestStatus.approve:
        dI<WorkDayBloc>().add(
          GetElectiveShift(
            completer: isUnScroll ? null : completer,
            data: WorkDayGetElectiveShiftRequest(
              pageSize: days,
              isApprove: true,
              startDate: startTime,
              endDate: endTime,
            ),
          ),
        );
        if (isUnScroll) {
          await completer.future;
          setState(() {
            isLoading = false;
          });
        }
        break;
      case WorkShiftRequestStatus.unusable:
        dI<WorkDayBloc>().add(
          GetElectiveShift(
            completer: completer,
            data: WorkDayGetElectiveShiftRequest(
              pageSize: days,
              isApprove: false,
              startDate: startTime,
              endDate: endTime,
            ),
          ),
        );
        if (isUnScroll) {
          await completer.future;
          setState(() {
            isLoading = false;
          });
        }
        break;
      case WorkShiftRequestStatus.pendingCancel:
        dI<WorkDayBloc>().add(GetWorkDayAdmin(
            completer: completer,
            data: WorkDayAdminRequest(
                pageSize: pagingInfo.pageSize + 7,
                requestStatus: WorkShiftRequestStatus.pendingCancel)));
        if (isUnScroll) {
          await completer.future;
          setState(() {
            isLoading = false;
          });
        }
        break;
      case WorkShiftRequestStatus.pending:
        dI<WorkDayBloc>().add(
          GetWorkDayAdmin(
            completer: completer,
            data: WorkDayAdminRequest(
              pageSize: pagingInfo.pageSize + 7,
              requestStatus: WorkShiftRequestStatus.pending,
            ),
          ),
        );
        if (isUnScroll) {
          await completer.future;
          setState(() {
            isLoading = false;
          });
        }
        break;
      default:
    }
  }

  ///-------------------------------------------
  _showBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return FilterDateTimeWork(
          onChangeFilterType: (value) => _setFilterType(value),
          callBack: () => _setTime(),
          endTime: endTime,
          startTime: startTime,
          changeEndTime: (value) => setEndTime(value),
          changeStartTime: (value) => setStartTime(value),
        );
      },
    );
  }

  _setFilterType(FilterType value) {
    setState(() {
      filterType = value;
    });
  }

  setEndTime(DateTime value) {
    setState(() {
      endTime = filterType == FilterType.day ? value : getLastDayOfMonth(value);
    });
  }

  setStartTime(DateTime value) {
    setState(() {
      startTime = filterType == FilterType.day ? value : getFirstDayOfMonth(value);
    });
  }

  _setTime() {
    if (widget.userType == UserType.user) {
      Completer completer = Completer();
      dI<WorkDayBloc>().add(GetWorkDayByUser(
          completer: completer,
          request: WorkDayGetElectiveShiftRequest(
              startDate: startTime, endDate: endTime, pageSize: 30, page: 1)));
    } else {
      _loadShift(type: selectType, isUnScroll: false);
    }
  }

  _removeFilter() {
    setState(() {
      filterType = FilterType.no;
      startTime = getFirstDayOfMonth(DateTime.now());
      endTime = getLastDayOfMonth(DateTime.now());
    });
  }

  String timeFilter() {
    if (filterType == FilterType.month) {
      return GetMonth.mapMonthName[startTime.month].toString();
    } else {
      return '${formatYMD(startTime.toString())} - ${formatYMD(endTime.toString())}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final tabStatus = widget.userType == UserType.manage
        ? [
            WorkShiftRequestStatus.pending,
            WorkShiftRequestStatus.pendingCancel,
            WorkShiftRequestStatus.approve,
            WorkShiftRequestStatus.usable,
          ]
        : [
            WorkShiftRequestStatus.approve,
            WorkShiftRequestStatus.pending,
            WorkShiftRequestStatus.pendingCancel,
            WorkShiftRequestStatus.cancel,
            WorkShiftRequestStatus.reject,
          ];
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
        actions: [
          InkWell(
            onTap: () => _showBottomSheet(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              child: SvgPicture.asset(
                Assets.images.icon.activateIcon.iconamoonOptionsThin,
                height: SpacingUnit.x6,
                width: SpacingUnit.x6,
                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              filterType == FilterType.no ? 0 : SpacingUnit.x12),
          child: filterType == FilterType.no
              ? const SizedBox()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: SpacingUnit.x4,
                    ),
                    Text(
                      filterType == FilterType.month
                          ? appLocalizations.filterByMonth
                          : appLocalizations.filterByDay,
                      style: TextStyle(
                          color: colors.primary, fontSize: SpacingUnit.x3_5),
                    ),
                    const SizedBox(
                      width: SpacingUnit.x4,
                    ),
                    ContainerBorder(
                      borderColors: colors.blue.withOpacity(0.2),
                      backgroundColors: colors.blue.withOpacity(0.2),
                      marginTop: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            timeFilter(),
                            style: TextStyle(
                                color: colors.primary,
                                fontSize: SpacingUnit.x3_5),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3,
                          ),
                          InkWell(
                            onTap: () => _removeFilter(),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x1),
                                border: Border.all(
                                  color: colors.primary,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                size: SpacingUnit.x4,
                                Icons.close,
                                color: colors.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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
                  itemCount: tabStatus.length,
                  itemBuilder: (context, index) {
                    final totalItems = state.items
                        .where((element) => element.status == tabStatus[index])
                        .length;
                    final items =
                        totalItems > 99 ? '99+' : totalItems.toString();
                    if (widget.userType == UserType.user) {
                      return InkWell(
                        onTap: () {
                          _onTapHeader(tabStatus[index]);
                          setState(() {
                            selectType = tabStatus[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x4,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: const BorderSide(width: 0),
                              bottom: selectType == tabStatus[index]
                                  ? BorderSide(
                                      width: 3,
                                      color: ColorUtils.parseHex('#808890'),
                                    )
                                  : const BorderSide(width: 0),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  tabStatus[index]
                                      .configWorkShiftRequestStatusName,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: tabStatus[index] == selectType
                                        ? null
                                        : ColorUtils.parseHex("#B2B7BC"),
                                  ),
                                ),
                                const SizedBox(width: SpacingUnit.x2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: SpacingUnit.x2,
                                    vertical: SpacingUnit.x1,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(SpacingUnit.x3),
                                    color: ColorUtils.parseHex("#EAF0FF"),
                                  ),
                                  child: Text(
                                    items,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: ColorUtils.parseHex("#2F6BFF"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          _onTapHeader(tabStatus[index]);
                          setState(() {
                            selectType = tabStatus[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x4,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: const BorderSide(width: 0),
                              bottom: selectType == tabStatus[index]
                                  ? BorderSide(
                                      width: 3,
                                      color: ColorUtils.parseHex('#808890'),
                                    )
                                  : const BorderSide(width: 0),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  tabStatus[index]
                                      .configWorkShiftRequestStatusName,
                                  style: theme.textTheme.titleMedium,
                                ),
                                index < 2
                                    ? Row(
                                        children: [
                                          const SizedBox(width: SpacingUnit.x2),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: SpacingUnit.x2,
                                              vertical: SpacingUnit.x1,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                SpacingUnit.x3,
                                              ),
                                              color: ColorUtils.parseHex(
                                                  "#EAF0FF"),
                                            ),
                                            child: Text(
                                              index == 0
                                                  ? state.totalPending > 99
                                                      ? '99+'
                                                      : state.totalPending
                                                          .toString()
                                                  : state.totalPendingCancel >
                                                          99
                                                      ? '99+'
                                                      : state.totalPendingCancel
                                                          .toString(),
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                color: ColorUtils.parseHex(
                                                  "#2F6BFF",
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              if (!isLoading) ...[
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
                    ),
                  )
                ] else ...[
                  if (selectType == WorkShiftRequestStatus.pending ||
                      selectType == WorkShiftRequestStatus.pendingCancel)
                    _Search(status: selectType),
                  if (selectType == WorkShiftRequestStatus.approve ||
                      selectType == WorkShiftRequestStatus.usable) ...[
                    if (state.electiveShiftItems.isEmpty) Container(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        color: colors.surfaceVariantLow.withOpacity(0.1),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: state.electiveShiftItems.length,
                          itemBuilder: (context, index) => ItemShiftApprove(
                              data: state.electiveShiftItems[index],
                              index: index,
                              type: selectType),
                        ),
                      ),
                    )
                  ] else ...[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        color: colors.surfaceVariantLow.withOpacity(0.1),
                        child: ListView.builder(
                          itemCount: state.items.length,
                          controller: scrollController,
                          itemBuilder: (context, index) => ItemPending(
                            data: state.items[index],
                            index: index,
                            type: selectType,
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
                      ),
                    )
                  ],
                ],
              ] else ...[
                const ShimmerLoad(),
              ],
            ],
          );
        },
      ),
    );
  }

  _onReject(
      {required String workShiftRequestId,
      required UserType userType,
      required WorkShiftRequestStatus type}) async {
    final appLocalizations = AppLocalizations.of(context)!;
    try {
      Completer completer = Completer<bool>();
      if (textEditingController.text.isEmpty && userType == UserType.manage) {
        ToastUtils().showError("Lý do không được bỏ trống");
      } else {
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
          _onBack();
        }
      }
    } catch (e) {
      ToastUtils().showError(appLocalizations.unsuccessful);
    }
  }

  _onBack() {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  _onCancel(
      {required String workShiftRequestId,
      required WorkShiftRequestStatus type}) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    textEditingController.text = '';
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
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    maxLines: 5,
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
                            onTap: () {
                              _onReject(
                                workShiftRequestId: workShiftRequestId,
                                type: type,
                                userType: widget.userType,
                              );
                            },
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
      builder: (BuildContext context) {
        return Dialog(
          child: DialogConfirm(
            onConfirm: () =>
                _onConfirm(workShiftRequestId: workShiftRequestId, type: type),
          ),
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

class ItemShiftApprove extends StatelessWidget {
  final int index;
  final WorkShiftRegisteredDetails data;
  final WorkShiftRequestStatus type;

  const ItemShiftApprove({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    // final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry: WorkDayAdminQueryParams(
                  id: data.workShiftSettingDetailId, type: type)
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
              Text(data.nameWorkShift,
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

class ItemPending extends StatelessWidget {
  final WorkDayAdmin data;
  final int index;
  final WorkShiftRequestStatus type;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  const ItemPending(
      {super.key,
      required this.data,
      required this.index,
      required this.type,
      required this.onConfirm,
      required this.onReject});

  _goDetail(context) {
    if (/*type == WorkShiftRequestStatus.approve || type == WorkShiftRequestStatus.unusable*/ true) {
      dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry:
              WorkDayAdminQueryParams(id: data.workShiftApproveId, type: type)
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
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: SpacingUnit.x16,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x2),
        child: TextField(
            controller: _textEditingController,
            onEditingComplete: () => _onSearch(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: colors.outline, width: 0.5),
                borderRadius: BorderRadius.circular(SpacingUnit.x10),
              ),
              contentPadding: const EdgeInsets.only(top: 10),
              isDense: true,
              hintText: appLocalizations.inputNameStaff,
              prefixIcon: InkWell(
                onTap: () => _onSearch(),
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

  void _onSearch() {
    FocusScope.of(context).unfocus();
    dI<WorkDayBloc>().add(
      GetWorkDayAdmin(
        data: WorkDayAdminRequest(
          requestStatus: widget.status,
          name: _textEditingController.text,
        ),
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
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x4),
        color: colors.background,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            color: colors.blue,
            colorText: colors.background,
            title: appLocalizations.confirm,
            onSubmit: () => onConfirm.call(),
          )
        ],
      ),
    );
  }
}
