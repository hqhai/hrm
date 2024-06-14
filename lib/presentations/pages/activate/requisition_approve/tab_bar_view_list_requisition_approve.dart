import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/item_list_requisition_approve.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class TabBarViewListRequistionApprove extends StatefulWidget {
  const TabBarViewListRequistionApprove({super.key, required this.status});

  final EnumStepRequestStatusEnum status;

  @override
  State<TabBarViewListRequistionApprove> createState() => _TabBarViewListRequistionApproveState();
}

class _TabBarViewListRequistionApproveState extends State<TabBarViewListRequistionApprove> {
  String? departmentId, startTime, endTime;
  String? requisitionTypeEnum;
  RequisitionEnum status = RequisitionEnum.getRequisitionsInit;
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;

  @override
  void initState() {
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
          page: 1,
          departmentId: departmentId,
          startTime: startTime,
          endTime: endTime,
          requisitionTypeEnum: _type(requisitionTypeEnum),
          status: widget.status.name),
    );
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  String? setText(String text) {
    if (text == '') {
      return null;
    }
    return text;
  }

  RequisitionTypeEnum? _type(String? requisitionTypeEnum) {
    if (requisitionTypeEnum?.isNotEmpty ?? false) {
      return RequisitionTypeEnum.values.firstWhere(
        (element) => element.name == requisitionTypeEnum,
      );
    }
    return null;
  }

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == RequisitionEnum.getRequisitionsSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequisitionApproveBloc>().add(
        GetRequisitionsApproveByFilterEvent(
            status: widget.status.name,
            page: pageIndex,
            departmentId: departmentId,
            startTime: startTime,
            endTime: endTime,
            requisitionTypeEnum: _type(requisitionTypeEnum)),
      );
    }
  }

  _listener(BuildContext context, RequisitionApproveState state) {
    if (state.status == RequisitionEnum.approveRequisitionInit) {
      progressIndicatorDialog(context);
    } else if (state.status == RequisitionEnum.approveRequisitionSuccess) {
      setState(() {
        status = RequisitionEnum.approveRequisitionSuccess;
      });
      Navigator.of(context).pop();
      dI<RequisitionApproveBloc>().add(
        GetRequisitionsApproveByFilterEvent(
            status: widget.status.name,
            page: 0,
            departmentId: departmentId,
            startTime: startTime,
            endTime: endTime,
            requisitionTypeEnum: _type(requisitionTypeEnum)),
      );
      successDialog(context);
    } else if (state.status == RequisitionEnum.approveRequisitionError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: height * 0.7,
            child: state.status == RequisitionEnum.getRequisitionsSuccess
                ? ListView.builder(
                    controller: controller,
                    itemCount: state.requisitions.length,
                    itemBuilder: (context, index) => ItemRequisitionApproveList(
                      id: state.requisitions[index].id,
                      status: widget.status,
                    ),
                  )
                : Center(
                    child: SizedBox(
                      height: SpacingUnit.x50,
                      width: SpacingUnit.x50,
                      child: Lottie.asset(Assets.images.icon.loading,
                          width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
                    ),
                  ),
          ),
        );
      },
    );
  }

/*List<Request> _getDataInStatus(
      {required List<Request> requestList}) {
    if (requestList.isEmpty) {
      return [];
    }
    if(widget.status!= EnumStepRequestStatusEnum.newStatus){
      return requestList;
    }

    final List<Request> requests = [];
    for (var requisition in requestList) {
      final stepRequests = requisition.stepRequests ?? [];
      final indexNewStepRequest = stepRequests
          .indexWhere((element) => element.status == EnumStepRequestStatusEnum.newStatus);
      if (indexNewStepRequest != -1) {
        final stepRequest = stepRequests[indexNewStepRequest];
        final stepRequestApproves = stepRequest.stepRequestApprovers ?? [];
        final userId = dI<UserBloc>().state.user.id;
        final int indexNewRequest = stepRequestApproves
            .indexWhere((element) => element.status == widget.status && element.approverId == userId);
        if (indexNewRequest != -1) {
          requests.add(requisition);
        }
      }
    }
    return requests;
  }*/
}
