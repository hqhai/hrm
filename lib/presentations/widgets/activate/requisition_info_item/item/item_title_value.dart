import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValue extends StatelessWidget {
  const ItemTitleValue(
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
      padding: const EdgeInsets.only(
          left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontSize: size ?? SpacingUnit.x3,
                fontWeight: font,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: SpacingUnit.x3),
              child: ContainerBorder(
                marginTop: 0,
                borderColors: colors.text.withOpacity(0.2),
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                        color: colors.text, fontSize: size ?? SpacingUnit.x3),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
