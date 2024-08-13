import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/tab_bar_view_list_requisition_self.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestSelf extends StatefulWidget {
  const ListviewRequestSelf(
      {super.key,
      required this.onChangeStatus,
      this.filterData = const FilterDialogModel(),
      required this.checkLoad});

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
        TabController(length: StatusRequestEnum.values.length, vsync: this)
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
              TabBar(
                labelColor: colors.background,
                isScrollable: true,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                tabAlignment: TabAlignment.start,
                tabs: StatusRequestEnum.values
                    .mapIndexed(
                      (index, status) => Tab(
                        child: Text(
                          status.configRequestStatusName,
                          style: TextStyle(
                              color: index == indexTab
                                  ? colors.text
                                  : colors.text.withOpacity(0.5),
                              fontSize: SpacingUnit.x3_5),
                        ),
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: Container(
                  color: colors.secondaryContainer.withOpacity(0.1),
                  child: TabBarView(
                    controller: _tabController,
                    children: StatusRequestEnum.values
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
