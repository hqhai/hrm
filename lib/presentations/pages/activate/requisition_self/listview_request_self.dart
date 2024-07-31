import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/tab_bar_view_list_requisition_self.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListviewRequestSelf extends StatefulWidget {
  const ListviewRequestSelf(
      {super.key, required this.onChangeStatus, this.filterData = const FilterDialogModel()});

  final ValueChanged<String> onChangeStatus;
  final FilterDialogModel filterData;

  @override
  State<ListviewRequestSelf> createState() => _ListviewRequestSelfState();
}

class _ListviewRequestSelfState extends State<ListviewRequestSelf>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this)..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return ContainerScreenMain(
          margin: 0,
          padding: SpacingUnit.x2,
          child: SizedBox(
            height: height * 0.85,
            child: DefaultTabController(
              length: 5,
              initialIndex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      tabs: StatusRequestEnum.values
                          .map(
                            (status) => Tab(
                              child: Text(
                                status.configRequestStatusName,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: TabBarView(
                      controller: _tabController,
                      children: StatusRequestEnum.values
                          .map((status) => TabBarViewListRequestSelf(
                                filterData: widget.filterData,
                                status: status,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _scrollListener() {
    widget.onChangeStatus.call(
      StatusRequestEnum.values[_tabController.index].name,
    );
  }
}
