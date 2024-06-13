import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_attach.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_general_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_sender_information.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionInformationPageRoute = GoRoute(
    path: Pages.requisitionInformationPage,
    name: Pages.requisitionInformationPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequisitionInformationPage(
        id: data['id'],
        checkUser: data['checkUser'],
      );
    });

class RequisitionInformationPage extends StatefulWidget {
  const RequisitionInformationPage(
      {super.key, this.id = '', this.checkUser = false});

  final String id;
  final bool checkUser;

  @override
  State<RequisitionInformationPage> createState() => _RequisitionInformationPageState();
}

class _RequisitionInformationPageState extends State<RequisitionInformationPage> {



  @override
  void initState() {
    dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
    super.initState();
  }

  _listener(BuildContext context, RequisitionState state) {
    dI<FlowBloc>().add(GetFlowEvent(id: state.requisition.flowId ?? ""));
    dI<UserByIdBloc>().add(GetUsersByIdEvent(ids: state.requisition.followerIds ?? []));
    if (state.requisition.config.subtitudePersons?.isNotEmpty ?? false) {
      dI<UserByIdBloc>()
          .add(GetSubtitudePersonsByIdEvent(ids: state.requisition.followerIds ?? []));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      builder: (context, state) {
        return BlocBuilder<FlowBloc, FlowState>(
          builder: (context, stateFlow) {
            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Column(
                    children: [
                      Text(stateFlow.flow.flowType?.configTypeName ?? "",
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                      Text('${appLocalizations.applicationCode} : ${state.requisition.code}',
                          style: TextStyle(
                              color: colors.surfaceVariantHigh, fontSize: SpacingUnit.x3)),
                    ],
                  ),
                ),
                actions: const [
                  SizedBox(
                    width: SpacingUnit.x15,
                  )
                ],
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                margin: const EdgeInsets.symmetric(
                    horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                decoration: BoxDecoration(
                  color: CustomsColor.colorBackground,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(SpacingUnit.x4),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RequisitionInformationSenderInformation(),
                      const RequisitionInformationGeneraliInformation(),
                      const RequisitionInformationType(),
                      const RequisitionInformationContent(),
                      const RequisitionInformationAttach(),
                      if (state.requisition.status == StatusRequestEnum.process &&
                          !widget.checkUser)
                        Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                                check: true, title: appLocalizations.delete, callback: () {})),
                      if (state.requisition.status == StatusRequestEnum.edit && !widget.checkUser)
                        Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                                check: true, title: appLocalizations.update, callback: () {})),
                      if (state.requisition.status == StatusRequestEnum.process && widget.checkUser)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonItemListRequisition(
                              title: appLocalizations.approver,
                              callback: () {},
                            ),
                            ButtonItemListRequisition(
                              title: appLocalizations.refuse,
                              callback: () {},
                            ),
                            ButtonItemListRequisition(
                              title: appLocalizations.modification,
                              callback: () {},
                            ),
                          ],
                        ),
                      if (state.requisition.status == StatusRequestEnum.approve && widget.checkUser)
                        Align(
                            alignment: Alignment.bottomRight,
                            child: ButtonItemListRequisition(
                                check: true, title: appLocalizations.cancel, callback: () {})),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
