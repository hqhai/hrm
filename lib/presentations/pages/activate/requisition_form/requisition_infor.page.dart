import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
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
        requisition: data['requisition'],
      );
    });

class RequisitionInformationPage extends StatefulWidget {
  const RequisitionInformationPage(
      {super.key,
      this.requisition = const Requisition(id: "", type: RequisitionTypeEnum.postalDelivery)});

  final Requisition requisition;

  @override
  State<RequisitionInformationPage> createState() => _RequisitionInformationPageState();
}

class _RequisitionInformationPageState extends State<RequisitionInformationPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Column(
                children: [
                  Text(widget.requisition.status?.configStatusName ?? "",
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6)),
                  Text(widget.requisition.id,
                      style: TextStyle(color: colors.surfaceVariantHigh, fontSize: SpacingUnit.x3)),
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
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.creator,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.name,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(widget.requisition.creator ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
