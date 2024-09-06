import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/tab_bar_view_list_requisition_follower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestFollower extends StatefulWidget {
  const ListviewRequestFollower(
      {super.key,
      required this.onChangeStatus,
      this.filterData = const FilterDialogModel(),
      required this.checkLoad});

  final ValueChanged<StatusRequestEnum> onChangeStatus;
  final FilterDialogModel filterData;
  final bool checkLoad;

  @override
  State<ListviewRequestFollower> createState() => _ListviewRequestFollowerState();
}

class _ListviewRequestFollowerState extends State<ListviewRequestFollower>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool checkLoad = true;

  @override
  void initState() {
    _tabController = TabController(length: StatusRequestEnum.values.length - 1, vsync: this)
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
                  color: colors.background,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: colors.textLight.withOpacity(0.1),
                    dividerHeight: 0.1,
                    indicatorColor: colors.textLight,
                    tabAlignment: TabAlignment.start,
                    tabs: StatusRequestEnum.values
                        .where((element) => element != StatusRequestEnum.unknown)
                        .map(
                      (status) {
                        final isActive =
                            StatusRequestEnum.values.indexOf(status) == _tabController.index;
                        return Tab(
                          child: Text(
                            status.getAppLocalizationName,
                            style: TextStyle(
                                fontWeight: isActive ? FontWeight.w600 : null,
                                color: isActive ? colors.text : colors.textLight,
                                fontSize: SpacingUnit.x4),
                          ),
                        );
                      },
                    ).toList(),
                  )),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: StatusRequestEnum.values
                      .where((element) => element != StatusRequestEnum.unknown)
                      .map((status) => TabBarViewListRequestFollower(
                            checkLoad: checkLoad && widget.checkLoad,
                            filterData: widget.filterData,
                            status: status,
                          ))
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
    widget.onChangeStatus.call(
      StatusRequestEnum.values[_tabController.index],
    );
    Completer completer = Completer<bool>();
    setState(() {
      checkLoad = false;
    });
    dI<RequisitionFollowingBloc>().add(GetRequisitionsFollowingByFilterEvent(
      completer: completer,
      type: widget.filterData.types,
      status: StatusRequestEnum.values[_tabController.index],
      userIds: widget.filterData.user?.code,
      departmentId: widget.filterData.department?.id,
      startTime: widget.filterData.startTime,
      endTime: widget.filterData.endTime,
      page: 1,
    ));
    final checkCompleter = await completer.future;
    if (checkCompleter) {
      setState(() {
        checkLoad = true;
      });
    }
  }
}
