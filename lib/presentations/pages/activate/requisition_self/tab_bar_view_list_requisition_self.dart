import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/item_list_requisition.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/erro_or_data_not_exist/data_not_exist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarViewListRequestSelf extends StatefulWidget {
  const TabBarViewListRequestSelf(
      {super.key,
      required this.status,
      this.filterData = const FilterDialogModel(),
      required this.checkLoad});

  final StatusRequestEnum status;
  final FilterDialogModel filterData;
  final bool checkLoad;

  @override
  State<TabBarViewListRequestSelf> createState() => _TabBarViewListRequestSelfState();
}

class _TabBarViewListRequestSelfState extends State<TabBarViewListRequestSelf> {
  late ScrollController controller;
  bool loadMore = true;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  bool checkLoad = true;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    if (lengthList < totalItems && controller.position.extentAfter < totalItems && checkLoad) {
      setState(() {
        checkLoad = false;
        pageIndex++;
      });
      Completer completer = Completer<bool>();
      dI<RequisitionBloc>().add(
        GetRequisitionsByFilterEvent(
          completer: completer,
          page: pageIndex,
          startTime: widget.filterData.startTime,
          endTime: widget.filterData.endTime,
          flowIds: widget.filterData.flows?.map((e) => e.id).toList(),
          status: widget.status,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Column(
          children: [
            widget.checkLoad
                ? state.requisitionIds.isNotEmpty
                    ? Expanded(
                      child: ListView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          itemCount: state.requisitionIds.length,
                          itemBuilder: (context, index) => ItemRequisitionList(
                            id: state.requisitionIds[index],
                          ),
                        ),
                    )
                    : const DataNotExist()
                : const ShimmerLoad(),
            const SizedBox(height: SpacingUnit.x7_5)
          ],
        );
      },
    );
  }
}
