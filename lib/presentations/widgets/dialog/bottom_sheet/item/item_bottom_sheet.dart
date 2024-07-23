import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemBottomSheet extends StatelessWidget {
  const ItemBottomSheet({super.key, this.index = 0, this.value = ''});
  final int index;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x2),
      margin: const EdgeInsets.all(SpacingUnit.x2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: colors.background,
        border: Border.all(
          color: colors.text,
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
