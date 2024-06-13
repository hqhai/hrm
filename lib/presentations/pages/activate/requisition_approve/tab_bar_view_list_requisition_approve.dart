import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/item_list_requisition_approve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarViewListRequistionApprove extends StatefulWidget {
  const TabBarViewListRequistionApprove({super.key, required this.type});

  final EnumStepRequestStatusEnum type;

  @override
  State<TabBarViewListRequistionApprove> createState() => _TabBarViewListRequistionApproveState();
}

class _TabBarViewListRequistionApproveState extends State<TabBarViewListRequistionApprove> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: SizedBox(
            height: height * 0.7,
            child: ListView.builder(
              itemCount: _getDataInType(type: widget.type, requestList: state.requisitions).length,
              itemBuilder: (context, index) => ItemRequisitionApproveList(
                  id: _getDataInType(type: widget.type, requestList: state.requisitions)[index].id),
            ),
          ),
        );
      },
    );
  }

  List<Request> _getDataInType(
      {required EnumStepRequestStatusEnum type, required List<Request> requestList}) {
    if (requestList.isEmpty) {
      return [];
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
            .indexWhere((element) => element.status == type && element.approverId == userId);
        if (indexNewRequest != -1) {
          requests.add(requisition);
        }
      }
    }
    return requests;
  }
}
