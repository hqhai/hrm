import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
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
    _tabController = TabController(length: EnumStepRequestStatusEnum.values.length - 1, vsync: this)
      ..addListener(_scrollListener);
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
                  color: colors.background,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: colors.textLight.withOpacity(0.1),
                    dividerHeight: 0.1,
                    indicatorColor: colors.textLight,
                    tabAlignment: TabAlignment.start,
                    tabs: EnumStepRequestStatusEnum.values
                        .where((element) => element != EnumStepRequestStatusEnum.unknown)
                        .map(
                      (status) {
                        final isActive = EnumStepRequestStatusEnum.values.indexOf(status) ==
                            _tabController.index;
                        return Tab(
                          child: Row(
                            children: [
                              Text(
                                status.configStepRequestStatusName,
                                style: TextStyle(
                                    fontWeight: isActive ? FontWeight.w600 : null,
                                    color: isActive ? colors.text : colors.textLight,
                                    fontSize: SpacingUnit.x4),
                              ),
                              BlocSelector<RequisitionApproveBloc, RequisitionApproveState, int>(
                                selector: (state) => state.statusRequestCount[status] ?? 0,
                                builder: (context, state) => Chip(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: colors.primary.withOpacity(0.3),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(style: BorderStyle.none),
                                      borderRadius: BorderRadius.circular(SpacingUnit.x6)),
                                  label: Text(
                                      countStatus(state),
                                    style: TextStyle(
                                        fontSize: SpacingUnit.x3_5,
                                        fontWeight: FontWeight.w400,
                                        color: colors.primary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  )),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: EnumStepRequestStatusEnum.values
                      .where((element) => element != EnumStepRequestStatusEnum.unknown)
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
    final check = await completer.future;
    if (check) {
      setState(() {
        checkLoad = true;
      });
    }
  }
}
