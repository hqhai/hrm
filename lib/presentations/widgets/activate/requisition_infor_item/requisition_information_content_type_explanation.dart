import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_explanation.dart';
import 'package:base_app/l10n/app_localizations.dart';
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
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.reason,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionExplanation.reason ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.reasonForExplanation,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionExplanation.reasonForExplanation ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SpacingUnit.x1,
              top: SpacingUnit.x2,
              bottom: SpacingUnit.x3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.totalMinute,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text((requisitionExplanation.totalMinute ?? 0).toString(),
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
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
