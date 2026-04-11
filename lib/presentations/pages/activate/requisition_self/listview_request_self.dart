import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/tab_bar_view_list_requisition_self.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestSelf extends StatefulWidget {
  const ListviewRequestSelf({
    super.key,
    required this.onChangeStatus,
    this.filterData = const FilterDialogModel(),
    required this.checkLoad,
  });

  final ValueChanged<StatusRequestEnum> onChangeStatus;
  final FilterDialogModel filterData;
  final bool checkLoad;

  @override
  State<ListviewRequestSelf> createState() => _ListviewRequestSelfState();
}

class _ListviewRequestSelfState extends State<ListviewRequestSelf>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool checkLoad = true;
  int indexTab = 0;

  @override
  void initState() {
    _tabController =
        TabController(length: StatusRequestEnum.values.length - 1, vsync: this)
          ..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return DefaultTabController(
          length: StatusRequestEnum.values.length,
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
                  tabs: StatusRequestEnum.values
                      .where((element) => element != StatusRequestEnum.unknown)
                      .mapIndexed((index, status) {
                    return Tab(
                      height: 36,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(status.getAppLocalizationName),
                          BlocSelector<RequisitionBloc, RequisitionState, int>(
                            selector: (state) => state.statusCount[status] ?? 0,
                            builder: (context, count) => count > 0
                                ? Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: colors.primary,
                                      borderRadius: BorderRadius.circular(10),
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
                  }).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: StatusRequestEnum.values
                      .where(
                          (element) => element != StatusRequestEnum.unknown)
                      .map(
                        (status) => TabBarViewListRequestSelf(
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
    /// sau khi thay đổi hoàn toàn mới thực hiện để tránh double call
    if (_tabController.indexIsChanging) {
      return;
    }
    widget.onChangeStatus.call(
      StatusRequestEnum.values[_tabController.index],
    );
    final Completer completer = Completer<bool>();
    setState(() {
      checkLoad = false;
      indexTab = _tabController.index;
    });
    dI<RequisitionBloc>().add(
      GetRequisitionsByFilterEvent(
        completer: completer,
        page: 1,
        startTime: widget.filterData.startTime,
        endTime: widget.filterData.endTime,
        flowIds: widget.filterData.flows?.map((e) => e.id).toList(),
        status: StatusRequestEnum.values[_tabController.index],
      ),
    );
    final check = await completer.future;
    if (check) {
      setState(() {
        checkLoad = true;
      });
    }
  }
}
