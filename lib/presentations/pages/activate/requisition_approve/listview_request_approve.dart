import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/tab_bar_view_list_requisition_approve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestApprove extends StatefulWidget {
  const ListviewRequestApprove(
      {super.key,
      required this.onChangeStatus,
      this.filterData = const FilterDialogModel(),
      required this.checkLoad});

  final ValueChanged<EnumStepRequestStatusEnum> onChangeStatus;
  final FilterDialogModel filterData;
  final bool checkLoad;

  @override
  State<ListviewRequestApprove> createState() => _ListviewRequestApproveState();
}

class _ListviewRequestApproveState extends State<ListviewRequestApprove>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool checkLoad = true;

  @override
  void initState() {
    _tabController = TabController(
      length: EnumStepRequestStatusEnum.values.length - 1,
      vsync: this,
    )..addListener(_scrollListener);
    super.initState();
    dI<RequisitionApproveBloc>().add(const GetRequisitionApproveCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return DefaultTabController(
          length: EnumStepRequestStatusEnum.values.length,
          initialIndex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: SpacingUnit.x4,
                  vertical: SpacingUnit.x2,
                ),
                decoration: BoxDecoration(
                  color: colors.text.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(SpacingUnit.x3),
                ),
                padding: const EdgeInsets.all(3),
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                    boxShadow: [
                      BoxShadow(
                        color: colors.text.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  labelColor: colors.text,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  unselectedLabelColor: colors.text.withValues(alpha: 0.5),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  tabAlignment: TabAlignment.start,
                  tabs: EnumStepRequestStatusEnum.values
                      .where((element) =>
                          element != EnumStepRequestStatusEnum.unknown)
                      .map(
                    (status) {
                      return Tab(
                        height: 36,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(status.configStepRequestStatusName),
                            BlocSelector<RequisitionApproveBloc,
                                RequisitionApproveState, int>(
                              selector: (state) =>
                                  state.statusRequestCount[status] ?? 0,
                              builder: (context, count) => count > 0
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 6),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        count > 99 ? '99+' : '$count',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: EnumStepRequestStatusEnum.values
                      .where((element) =>
                          element != EnumStepRequestStatusEnum.unknown)
                      .map(
                        (status) => TabBarViewListRequistionApprove(
                          checkLoad: checkLoad && widget.checkLoad,
                          filterData: widget.filterData,
                          status: status,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _scrollListener() async {
    if (_tabController.indexIsChanging) {
      return;
    }
    widget.onChangeStatus.call(
      EnumStepRequestStatusEnum.values[_tabController.index],
    );
    final Completer completer = Completer<bool>();
    setState(() {
      checkLoad = false;
    });
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
        completer: completer,
        page: 1,
        departmentId: widget.filterData.department?.id,
        startTime: widget.filterData.startTime,
        endTime: widget.filterData.endTime,
        type: widget.filterData.types,
        status: EnumStepRequestStatusEnum.values[_tabController.index],
        userIds: widget.filterData.user?.code,
      ),
    );
    dI<RequisitionApproveBloc>().add(const ResetAllIdRequisitionApproveEvent());
    final check = await completer.future;
    if (check) {
      setState(() {
        checkLoad = true;
      });
    }
  }
}
