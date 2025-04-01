import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemBottomSheet extends StatelessWidget {
  const ItemBottomSheet(
      {super.key, this.index = 0, this.value = '', required this.check});

  final int index;
  final String value;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      margin: const EdgeInsets.symmetric(
          horizontal: SpacingUnit.x6, vertical: SpacingUnit.x2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color:
            check ? colors.tertiary.withValues(alpha: 0.4) : colors.background,
        border: Border.all(
          color: colors.background,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            '${index + 1}.    ',
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
            ),
          ),
        ],
      ),
    );
  }
}
