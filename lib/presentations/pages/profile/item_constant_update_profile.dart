import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemUpdateProfileConstant extends StatelessWidget {
  const ItemUpdateProfileConstant({super.key, this.title = '', this.content = ''});

  final String title, content;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
        ),
        Container(
          width: width,
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          padding: const EdgeInsets.all(SpacingUnit.x2_5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x2),
            color: CustomsColor.colorBackground,
            border: Border.all(
              color: colors.surfaceBright,
              width: 1,
            ),
          ),
          child: Text(
            content,
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
          ),
        ),
      ],
    );
  }
}
