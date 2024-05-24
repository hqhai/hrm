import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FormChangeMonthAttendanceHistory extends StatelessWidget {
  final String year;
  final String month;
  final VoidCallback upMonth;
  final VoidCallback downMonth;
  const FormChangeMonthAttendanceHistory(
      {super.key,
        required this.year,
        required this.month,
        required this.upMonth,
        required this.downMonth});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Container(
      alignment: Alignment.center,
      height: SpacingUnit.x16,
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$month $year",
              style: theme.textTheme.titleLarge,
            ),
          ),
          InkWell(
            onTap: () => upMonth.call(),
            child: Icon(
              Icons.arrow_drop_up,
              color: colors.textTertiary,
              size: 50,
            ),
          ),
          const SizedBox(
            width: SpacingUnit.x4,
          ),
          InkWell(
            onTap: () => downMonth.call(),
            child: Icon(
              Icons.arrow_drop_down,
              color: colors.textTertiary,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

