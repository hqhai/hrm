import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/tab_bar_view_list_requisition_approve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestApprove extends StatefulWidget {
  const ListviewRequestApprove(
      {super.key, required this.onChangeStatus, this.filterData = const FilterDialogModel()});

  final ValueChanged<String> onChangeStatus;
  final FilterDialogModel filterData;

  @override
  State<ListviewRequestApprove> createState() => _ListviewRequestApproveState();
}

class _ListviewRequestApproveState extends State<ListviewRequestApprove>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this)..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          height: height * 0.78,
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x1),
            ),
          ),
          child: DefaultTabController(
            length: 5,
            initialIndex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: EnumStepRequestStatusEnum.values
                      .map(
                        (status) => Tab(
                          child: Text(
                            status.configStepRequestStatusName,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: height * 0.7,
                  child: TabBarView(
                      controller: _tabController,
                      children: EnumStepRequestStatusEnum.values
                          .map((status) => TabBarViewListRequistionApprove(
                                filterData: widget.filterData,
                                status: status,
                              ))
                          .toList()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _scrollListener() {
    widget.onChangeStatus.call(
      EnumStepRequestStatusEnum.values[_tabController.index].name,
    );
  }
}
