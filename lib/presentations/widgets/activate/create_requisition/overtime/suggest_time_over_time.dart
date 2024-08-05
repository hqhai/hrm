import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class SuggestTimeOverTime extends StatelessWidget {
  const SuggestTimeOverTime({super.key, this.suggestTime = ''});

  final String suggestTime;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            appLocalizations.time,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical:  SpacingUnit.x3),
            padding: const EdgeInsets.all( SpacingUnit.x1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SpacingUnit.x3),
              border: Border.all(
                color: colors.outline.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                suggestTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
