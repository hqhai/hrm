import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValueNoBorderColum extends StatelessWidget {
  const ItemTitleValueNoBorderColum(
      {super.key,
      required this.title,
      required this.value,
      this.size,
      this.font,
      this.leftPadding});

  final String title, value;
  final double? size;
  final FontWeight? font;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? SpacingUnit.x1,
        top: SpacingUnit.x2,
        bottom: SpacingUnit.x2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: size ?? SpacingUnit.x3,
              fontWeight: font,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x3,
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
