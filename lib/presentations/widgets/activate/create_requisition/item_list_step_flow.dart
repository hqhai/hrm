import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/step_flow.dart';
import 'package:base_app/domain/entities/requisition/step_requests.dart';
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
                              note: setNote(
                                  stateRequisition.requisition.stepRequests,
                                  element),
                              checkApprove: _setCheckAppRove(
                                  stepRequests:
                                      stateRequisition.requisition.stepRequests,
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
      {required List<StepRequests> stepRequests,
      required int indexData,
      required List<StepFlow> stepFlows}) {
    final itemsRequest = stepRequests
        .where(
            (element) => element.status == EnumStepRequestStatusEnum.newStatus)
        .toList();
    if (itemsRequest.isEmpty) return false;
    final stepFlowId = itemsRequest[0].stepFlowId;
    final index = stepFlows.indexWhere((element) => element.id == stepFlowId);
    if (index == -1) return false;
    if (indexData <= index) return true;
    return false;
  }

  String setNote(List<StepRequests> stepRequests, StepFlow sFlow) {
    final indexStepRequests =
        stepRequests.indexWhere((element) => element.stepFlowId == sFlow.id);
    if (indexStepRequests != -1 && !create) {
      final stepRequest = stepRequests[indexStepRequests];
      final stepRequestApprover = stepRequest.stepRequestApprovers ?? [];
      final indexStepRequestApprove = stepRequestApprover
          .indexWhere((element) => element.note?.isNotEmpty ?? false);
      if (indexStepRequestApprove != -1 && !create) {
        return stepRequestApprover[indexStepRequestApprove].note ?? "";
      }
    }
    return '';
  }
}
