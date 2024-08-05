import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/item_list_requisition_follower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class TabBarViewListRequestFollower extends StatefulWidget {
  const TabBarViewListRequestFollower(
      {super.key, required this.status, this.filterData = const FilterDialogModel()});

  final StatusRequestEnum status;
  final FilterDialogModel filterData;

  @override
  State<TabBarViewListRequestFollower> createState() => _TabBarViewListRequestFollowerState();
}

class _TabBarViewListRequestFollowerState extends State<TabBarViewListRequestFollower> {
  late ScrollController controller;
  bool loadMore = true;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  bool checkLoad = true;

  @override
  void initState() {
    dI<RequisitionFollowingBloc>().add(
      GetRequisitionsFollowingByFilterEvent(
        page: 1,
        startTime: widget.filterData.startTime,
        endTime: widget.filterData.endTime,
        userIds: widget.filterData.user?.code,
        departmentId: widget.filterData.department?.id,
        type: widget.filterData.types,
        status: widget.status,
      ),
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    if (lengthList < totalItems &&
        controller.position.extentAfter < totalItems && checkLoad) {
      setState(() {
        pageIndex++;
        checkLoad = false;
      });
      Completer completer = Completer<bool>();
      dI<RequisitionFollowingBloc>().add(
        GetRequisitionsFollowingByFilterEvent(
          completer: completer,
          page: 1,
          startTime: widget.filterData.startTime,
          endTime: widget.filterData.endTime,
          userIds: widget.filterData.user?.code,
          departmentId: widget.filterData.department?.id,
          type: widget.filterData.types,
          status: widget.status,
        ),
      );
      final check = await completer.future;
      if (check){
        setState(() {
          checkLoad = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: colors.outlineVariant.withOpacity(0.1),
            height: height * 0.85,
            child: ListView.builder(
              controller: controller,
              itemCount: state.requisitions.length,
              itemBuilder: (context, index) => ItemRequisitionFollowerList(
                id: state.requisitionIds[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
