import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationSenderInformation extends StatelessWidget {
  const RequisitionInformationSenderInformation({super.key});

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
                appLocalizations.senderInformation,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              item(
                title: appLocalizations.fullName,
                color: colors.text,
                value: state.requisition.createdFullName,
              ),
              item(
                title: appLocalizations.employeeCode,
                color: colors.text,
                value: state.requisition.createdCode,
              ),
              item(
                title: appLocalizations.position,
                color: colors.text,
                value: state.requisition.nameCreatedPosition,
              ),
              item(
                title: appLocalizations.department,
                color: colors.text,
                value: state.requisition.nameCreatedDepartment,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget item({required String title, required String value, required Color color}) {
    return Padding(
      padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
