import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionInformationSenderInformation extends StatelessWidget {
  const RequisitionInformationSenderInformation(
      {super.key,
      this.creator = '',
      this.creatorId = '',
      this.position = '',
      this.department = ''});

  final String creator, creatorId, position, department;

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
            appLocalizations.senderInformation,
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
                Text(appLocalizations.fullName,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(creator, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.employeeCode,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(creatorId, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.position,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(position, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.department,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(department, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
