import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/step_flow.dart';
import 'package:base_app/domain/entities/reqisition/step_requests.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_step_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemListStepFlow extends StatelessWidget {
  const ItemListStepFlow({super.key, this.create = true});

  final bool create;

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
                    create ? appLocalizations.flow : appLocalizations.trackFlowProgres,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                    child: Column(
                      children: state.flow.stepFlows
                          .map(
                            (element) => ItemStepFlow(
                              note: setNote(stateRequisition.requisition.stepRequests, element),
                              checkApprove: setCheckAppRove(
                                  stateRequisition.requisition.stepRequests, element),
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

  bool setCheckAppRove(List<StepRequests> stepRequests, StepFlow sFlow) {
    final indexStepRequests = stepRequests.indexWhere((element) => element.stepFlowId == sFlow.id);
    if (sFlow.type == EnumStepFlowType.start) {
      return true;
    }
    if (indexStepRequests != -1 && !create) {
      final stepRequest = stepRequests[indexStepRequests];
      return stepRequest.status == EnumStepRequestStatusEnum.approve;
    }
    return false;
  }

  String setNote(List<StepRequests> stepRequests, StepFlow sFlow) {
    final indexStepRequests = stepRequests.indexWhere((element) => element.stepFlowId == sFlow.id);
    if (indexStepRequests != -1 && !create) {
      final stepRequest = stepRequests[indexStepRequests];
      final stepRequestApprovers = stepRequest.stepRequestApprovers ?? [];
      final indexStepRequestApprove =
          stepRequestApprovers.indexWhere((element) => element.note?.isNotEmpty ?? false);
      if (indexStepRequestApprove != -1 && !create) {
        return stepRequestApprovers[indexStepRequestApprove].note ?? "";
      }
    }
    return '';
  }
}
