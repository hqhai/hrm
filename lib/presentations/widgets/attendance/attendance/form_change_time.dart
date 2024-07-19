import 'package:base_app/l10n/app_localizations.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FormChangeTime extends StatelessWidget {
  final String year;
  final String month;
  final VoidCallback upMonth;
  final VoidCallback downMonth;
  const FormChangeTime(
      {super.key,
      required this.year,
      required this.month,
      required this.upMonth,
      required this.downMonth});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      alignment: Alignment.center,
      height: SpacingUnit.x16,
      margin:  const EdgeInsets.only(bottom: SpacingUnit.x0_5),
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => downMonth.call(),
            child: Icon(
              Icons.arrow_left_outlined,
              color: colors.textTertiary,
              size: 50,
            ),
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              " ${appLocalizations.month} $month, $year",
              style: theme.textTheme.titleLarge,
            ),
          ),
          InkWell(
            onTap: () => upMonth.call(),
            child: Icon(
              Icons.arrow_right_outlined,
              color: colors.textTertiary,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
