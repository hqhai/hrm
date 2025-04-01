import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleValueColum extends StatelessWidget {
  const ItemTitleValueColum(
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
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(
          left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x1),
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
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x3),
            child: ContainerBorder(
              paddingVertical: SpacingUnit.x4,
              width: width,
              marginTop: 0,
              borderColors: colors.text.withValues(alpha: 0.2),
              child: Text(
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
