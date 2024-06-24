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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x4,
      ),
      child: Row(
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
            child: Text(
              suggestTime,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
