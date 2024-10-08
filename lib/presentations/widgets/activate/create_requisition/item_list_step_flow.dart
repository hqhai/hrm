import 'package:base_app/common/enum/boundary_status.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/requisition/step_flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_step_flow.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemListStepFlow extends StatelessWidget {
  final bool create;

  const ItemListStepFlow({super.key, this.create = true});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, stateRequisition) {
        return BlocBuilder<FlowBloc, FlowState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    create
                        ? appLocalizations.flow
                        : appLocalizations.trackFlowProgres,
                    style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                    child: Column(
                      children: state.flow.stepFlows
                          .mapIndexed(
                            (index, element) => ItemStepFlow(
                              note: '',
                              checkApprove: _setCheckAppRove(
                                  request: stateRequisition.requisition,
                                  indexData: index,
                                  stepFlows: state.flow.stepFlows),
                              nameUserApprove: element.name,
                              isNotFirst: element.type != EnumStepFlowType.end,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  bool _setCheckAppRove(
      {required Request request,
      required int indexData,
      required List<StepFlow> stepFlows}) {
    final stepRequests = request.stepRequests;
    if (request.status == StatusRequestEnum.approve ||
        request.status == StatusRequestEnum.reject ||
        request.status == StatusRequestEnum.cancel) return true;
    if (request.status == StatusRequestEnum.overdueApprove ||
        request.status == StatusRequestEnum.overdueEdit) return false;
    if (stepRequests.isEmpty) return false;
    final dates =
        stepRequests.map((e) => e.createdDate ?? DateTime.now()).toList();
    final date = _nearestDate(data: dates);
    final itemsRequest = stepRequests
        .where((element) =>
            element.createdDate == date &&
            (request.status == StatusRequestEnum.edit
                ? element.boundaryStatus == EnumBoundaryStatus.newStatus
                : element.status == EnumStepRequestStatusEnum.newStatus))
        .toList();
    if (itemsRequest.isEmpty) return false;
    final stepFlowId = itemsRequest[0].stepFlowId;
    int index = stepFlows.indexWhere((element) => element.id == stepFlowId);
    if (index == -1) return false;
    if (indexData <= index) return true;
    return false;
  }

  DateTime _nearestDate({required List<DateTime> data}) {
    DateTime now = DateTime.now();
    DateTime nearestDate = data[0];
    for (DateTime date in data) {
      if ((date.difference(now).abs()).inSeconds <
          (nearestDate.difference(now).abs()).inSeconds) {
        nearestDate = date;
      }
    }

    return nearestDate;
  }
}
