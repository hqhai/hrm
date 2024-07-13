import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/item_request_on_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestTab extends StatelessWidget {
  const RequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: state.requisitions
                .map(
                  (e) => ItemRequestOnTab(id: e.id),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
