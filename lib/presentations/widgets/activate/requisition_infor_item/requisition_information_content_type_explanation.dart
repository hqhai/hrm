import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_explanation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeExplanation extends StatelessWidget {
  const RequisitionInformationContentTypeExplanation(
      {super.key, this.requisitionExplanation = const RequisitionExplanation()});

  final RequisitionExplanation requisitionExplanation;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.contentOfApplication,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          ItemTitleValue(
            title: appLocalizations.reason,
            value: requisitionExplanation.reason ?? "",
          ),
          ItemTitleValue(
            title: appLocalizations.reasonForExplanation,
            value: requisitionExplanation.reasonForExplanation ?? "",
          ),
          ItemTitleValue(
            title: appLocalizations.totalMinute,
            value: (requisitionExplanation.totalMinute ?? 0).toString(),
          ),
          Text(
            appLocalizations.detailedDescription,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Text(
              requisitionExplanation.detailedDescription ?? "",
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
