import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemSelected extends StatelessWidget {
  final String label;
  final bool isActive;
  const ItemSelected({super.key, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x2_5),
      margin: const EdgeInsets.only(bottom: SpacingUnit.x3),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(SpacingUnit.x2),
          border:
              Border(bottom: BorderSide(width: 0.1, color: colors.textLight))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
          if (isActive)
            Icon(
              Icons.check,
              color: colors.primary,
            )
        ],
      ),
    );
  }
}
