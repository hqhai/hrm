import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FormChangeMonth extends StatelessWidget {
  final String year;
  final String month;
  final VoidCallback upMonth;
  final VoidCallback downMonth;
  const FormChangeMonth(
      {super.key,
      required this.year,
      required this.month,
      required this.upMonth,
      required this.downMonth});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Container(
      alignment: Alignment.center,
      height: SpacingUnit.x16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => downMonth.call(),
            child: Icon(
              Icons.arrow_left,
              color: colors.textTertiary,
              size: SpacingUnit.x8,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "${appLocalizations.month} $month, $year",
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => upMonth.call(),
            child: Icon(
              Icons.arrow_right,
              color: colors.textTertiary,
              size: SpacingUnit.x8,
            ),
          ),
        ],
      ),
    );
  }
}
