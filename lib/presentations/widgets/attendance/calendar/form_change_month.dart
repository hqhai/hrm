import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FormChangeMonth extends StatelessWidget {
  final String year;
  final String month;
  final VoidCallback upMonth;
  final VoidCallback downMonth;
  final VoidCallback? onTodayPressed;

  const FormChangeMonth({
    super.key,
    required this.year,
    required this.month,
    required this.upMonth,
    required this.downMonth,
    this.onTodayPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(
            "${l10n.month} $month, $year",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.text,
            ),
          ),
        ),
        if (onTodayPressed != null)
          Padding(
            padding: const EdgeInsets.only(right: SpacingUnit.x2),
            child: GestureDetector(
              onTap: onTodayPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingUnit.x3,
                  vertical: SpacingUnit.x1_5,
                ),
                decoration: BoxDecoration(
                  color: colors.text.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(SpacingUnit.x5),
                ),
                child: Text(
                  l10n.today,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.text.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        GestureDetector(
          onTap: downMonth,
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x1),
            child: Icon(
              Icons.chevron_left_rounded,
              color: colors.text.withValues(alpha: 0.5),
              size: SpacingUnit.x7,
            ),
          ),
        ),
        GestureDetector(
          onTap: upMonth,
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x1),
            child: Icon(
              Icons.chevron_right_rounded,
              color: colors.text.withValues(alpha: 0.5),
              size: SpacingUnit.x7,
            ),
          ),
        ),
      ],
    );
  }
}
