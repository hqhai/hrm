import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationGeneraliInformation extends StatelessWidget {
  const RequisitionInformationGeneraliInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.generalInformation,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.type,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(state.requisition.flowId ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.status,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(state.requisition.status?.configRequestStatusName ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.applicationCode,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(state.requisition.id,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.createTime,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(state.requisition.createdDate ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appLocalizations.follower,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                    Text(state.requisition.followerIds?.first ?? "",
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
