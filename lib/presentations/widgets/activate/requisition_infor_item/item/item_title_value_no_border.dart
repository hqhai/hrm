import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValueNoBorder extends StatelessWidget {
  const ItemTitleValueNoBorder(
      {super.key,
      required this.title,
      required this.value,
      this.size,
      this.font,
      this.spaceBetween = true});

  final String title, value;
  final double? size;
  final FontWeight? font;
  final bool spaceBetween;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: spaceBetween ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: size ?? SpacingUnit.x3,
              fontWeight: font,
            ),
          ),
          spaceBetween
              ? Expanded(
                  child: Text(
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    value,
                    style: TextStyle(color: colors.text, fontSize: size ?? SpacingUnit.x3),
                  ),
                )
              : Text(
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  '   $value',
                  style: TextStyle(color: colors.text, fontSize: size ?? SpacingUnit.x3),
                ),
        ],
      ),
    );
  }
}
