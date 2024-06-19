import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/item_list_requisition_approve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class TabBarViewListRequistionApprove extends StatefulWidget {
  const TabBarViewListRequistionApprove(
      {super.key, required this.status, this.filterData = const FilterDialogModel()});

  final EnumStepRequestStatusEnum status;
  final FilterDialogModel filterData;

  @override
  State<TabBarViewListRequistionApprove> createState() => _TabBarViewListRequistionApproveState();
}

class _TabBarViewListRequistionApproveState extends State<TabBarViewListRequistionApprove> {
  RequisitionEnum status = RequisitionEnum.init;
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;

  @override
  void initState() {
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
          page: 1,
          departmentId: widget.filterData.department?.id,
          startTime: widget.filterData.startTime,
          endTime: widget.filterData.endTime,
          requisitionTypeEnum: widget.filterData.type,
          status: widget.status.name),
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == RequisitionEnum.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequisitionApproveBloc>().add(
        GetRequisitionsApproveByFilterEvent(
            status: widget.status.name,
            page: pageIndex,
            departmentId: widget.filterData.department?.id,
            startTime: widget.filterData.startTime,
            endTime: widget.filterData.endTime,
            requisitionTypeEnum: widget.filterData.type),
      );
    }
  }

  _listener(BuildContext context, RequisitionApproveState state) {
    setState(() {
      status = state.statusGet;
      totalItems = state.countItem;
      lengthList = state.requisitions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => _listenWhen(previous.statusGet, current.statusGet),
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: height * 0.7,
            child: state.statusGet == RequisitionEnum.init && state.requisitions.isEmpty
                ? Center(
                    child: SizedBox(
                      height: SpacingUnit.x50,
                      width: SpacingUnit.x50,
                      child: Lottie.asset(
                        Assets.images.icon.loading,
                        width: SpacingUnit.x50,
                        height: SpacingUnit.x50,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: controller,
                    itemCount: state.requisitions.length,
                    itemBuilder: (context, index) => ItemRequisitionApproveList(
                      id: state.requisitions[index].id,
                      status: widget.status,
                    ),
                  ),
          ),
        );
      },
    );
  }

  bool _listenWhen(RequisitionEnum requisitionsP, RequisitionEnum requisitionsC) {
    return requisitionsP != requisitionsC;
  }
}
