import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RequisitionOvertimeHeader extends StatelessWidget {
  const RequisitionOvertimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizations.time,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: SpacingUnit.x3_5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                appLocalizations.i18nTotalHour,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: SpacingUnit.x3_5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                appLocalizations.i18nRate,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontSize: SpacingUnit.x3_5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: Color(0xFF000000),
        )
      ],
    );
  }
}
