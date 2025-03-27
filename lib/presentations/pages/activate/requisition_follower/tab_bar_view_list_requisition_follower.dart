import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/item_list_requisition_follower.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/erro_or_data_not_exist/data_not_exist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class TabBarViewListRequestFollower extends StatefulWidget {
  const TabBarViewListRequestFollower(
      {super.key,
      required this.status,
      this.filterData = const FilterDialogModel(),
      required this.checkLoad});

  final StatusRequestEnum status;
  final FilterDialogModel filterData;
  final bool checkLoad;

  @override
  State<TabBarViewListRequestFollower> createState() =>
      _TabBarViewListRequestFollowerState();
}

class _TabBarViewListRequestFollowerState
    extends State<TabBarViewListRequestFollower> {
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
    if (lengthList < totalItems &&
        controller.position.extentAfter < totalItems &&
        checkLoad) {
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
      if (check) {
        setState(() {
          checkLoad = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
      builder: (context, state) {
        return Container(
          color: colors.outlineVariant.withValues(alpha: 0.1),
          child: Column(
            children: [
              widget.checkLoad
                  ? state.requisitionIds.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            controller: controller,
                            shrinkWrap: true,
                            itemCount: state.requisitionIds.length,
                            itemBuilder: (context, index) =>
                                ItemRequisitionFollowerList(
                              id: state.requisitionIds[index],
                            ),
                          ),
                        )
                      : const DataNotExist()
                  : const ShimmerLoad(),
              const SizedBox(height: SpacingUnit.x7_5)
            ],
          ),
        );
      },
    );
  }
}
