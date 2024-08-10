import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValueNoBorder extends StatelessWidget {
  const ItemTitleValueNoBorder({super.key, required this.title, required this.value, this.size, this.font});

  final String title, value;
  final double? size;
  final FontWeight? font;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding:
      const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: size ?? SpacingUnit.x3,
              fontWeight: font,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: colors.text, fontSize: size ?? SpacingUnit.x3),
          )
        ],
      ),
    );
  }
}
