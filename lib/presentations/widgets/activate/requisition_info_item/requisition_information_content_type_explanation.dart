import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_explanation.dart';
import 'package:collection/collection.dart';
import 'package:common/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeExplanation extends StatefulWidget {
  const RequisitionInformationContentTypeExplanation({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeExplanation> createState() =>
      _RequisitionInformationContentTypeExplanationState();
}

class _RequisitionInformationContentTypeExplanationState
    extends State<RequisitionInformationContentTypeExplanation> {
  @override
  void initState() {
    final data = dI<RequisitionBloc>().state.requisition.config.explanations;
    if (data.isNotEmpty) {
      dI<WorkSheetBloc>().add(GetAttendanceByListDateEvent(
        dates: data.length != 1
            ? [
                getStringDate(data.first.workDate ?? DateTime.now()),
                getStringDate(data.last.workDate ?? DateTime.now()),
              ]
            : [
                getStringDate(data.first.workDate ?? DateTime.now()),
                getStringDate(data.first.workDate ?? DateTime.now()),
              ],
        userId: dI<UserBloc>().state.user.id,
      ));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        final explanations = state.requisition.config.explanations;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.contentOfApplication,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                  children: explanations
                      .mapIndexed((index, element) => ItemExplanation(
                            explanation: element,
                          ))
                      .toList())
            ],
          ),
        );
      },
    );
  }
}
