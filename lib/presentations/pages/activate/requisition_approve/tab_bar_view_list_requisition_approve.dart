import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/item_list_requisition_approve.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/erro_or_data_not_exist/data_not_exist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class TabBarViewListRequistionApprove extends StatefulWidget {
  final EnumStepRequestStatusEnum status;
  final FilterDialogModel filterData;
  final bool checkLoad;

  const TabBarViewListRequistionApprove({
    super.key,
    required this.status,
    this.filterData = const FilterDialogModel(),
    required this.checkLoad,
  });

  @override
  State<TabBarViewListRequistionApprove> createState() => _TabBarViewListRequistionApproveState();
}

class _TabBarViewListRequistionApproveState extends State<TabBarViewListRequistionApprove> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  bool checkLoad = true;

  @override
  void initState() {
    final state = dI<RequisitionApproveBloc>().state;
    totalItems = state.countItem;
    lengthList = state.requisitions.length;
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    if (lengthList < totalItems && controller.position.extentAfter < totalItems && checkLoad) {
      setState(() {
        pageIndex++;
        checkLoad = false;
      });
      Completer completer = Completer<bool>();
      dI<RequisitionApproveBloc>().add(
        GetRequisitionsApproveByFilterEvent(
          completer: completer,
          page: pageIndex,
          departmentId: widget.filterData.department?.id,
          startTime: widget.filterData.startTime,
          endTime: widget.filterData.endTime,
          type: widget.filterData.types,
          status: widget.status,
          userIds: widget.filterData.user?.id,
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

  _listener(BuildContext context, RequisitionApproveState state) {
    setState(() {
      totalItems = state.countItem;
      lengthList = state.requisitions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.requisitions != current.requisitions,
      // buildWhen: (previous, current) => previous.requisitionIds != current.requisitionIds ,
      builder: (context, state) {
        return Container(
          color: colors.outlineVariant.withOpacity(0.1),
          height: height * 0.85,
          child: widget.checkLoad
              ? state.requisitionIds.isNotEmpty
                  ? ListView.builder(
                      controller: controller,
                      itemCount: state.requisitionIds.length,
                      itemBuilder: (context, index) => ItemRequisitionApproveList(
                        id: state.requisitionIds[index],
                        status: widget.status,
                        departmentId: widget.filterData.department?.id,
                        startTime: widget.filterData.startTime,
                        endTime: widget.filterData.endTime,
                        type: widget.filterData.types,
                      ),
                    )
                  : const DataNotExist()
              : const ShimmerLoad(),
        );
      },
    );
  }
}
