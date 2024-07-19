import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValue extends StatelessWidget {
  const ItemTitleValue({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
          Text(value,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
        ],
      ),
    );
  }
}
