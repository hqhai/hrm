import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/item_list_requisition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class TabBarViewListRequestSelf extends StatefulWidget {
  const TabBarViewListRequestSelf(
      {super.key, required this.status, this.filterData = const FilterDialogModel()});

  final StatusRequestEnum status;
  final FilterDialogModel filterData;

  @override
  State<TabBarViewListRequestSelf> createState() => _TabBarViewListRequestSelfState();
}

class _TabBarViewListRequestSelfState extends State<TabBarViewListRequestSelf> {
  late ScrollController controller;
  bool loadMore = true;
  int pageIndex = 1, totalItems = 0, lengthList = 0;

  @override
  void initState() {
    dI<RequisitionBloc>().add(
      GetRequisitionsByFilterEvent(
        page: 1,
        startTime: widget.filterData.startTime,
        endTime: widget.filterData.endTime,
        flowIds: widget.filterData.flows?.map((e) => e.id).toList(),
        status: widget.status,
      ),
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequisitionBloc>().add(
        GetRequisitionsByFilterEvent(
          page: pageIndex,
          startTime: widget.filterData.startTime,
          endTime: widget.filterData.endTime,
          flowIds: widget.filterData.flows?.map((e) => e.id).toList(),
          status: widget.status,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: colors.outlineVariant.withOpacity(0.1),
            height: height * 0.85,
            child: ListView.builder(
              controller: controller,
              itemCount: state.requisitions.length,
              itemBuilder: (context, index) => ItemRequisitionList(
                id: state.requisitionIds[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
