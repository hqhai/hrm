import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleRange extends StatelessWidget {
  const ItemTitleRange(
      {super.key,
      required this.title,
      required this.value,
      this.size,
      this.font});

  final String title, value;
  final double? size;
  final FontWeight? font;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
            width: SpacingUnit.x2_5,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                maxLines: 2,
                value,
                style: TextStyle(
                    color: colors.text, fontSize: size ?? SpacingUnit.x3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
