import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemIntoMoney extends StatelessWidget {
  const ItemIntoMoney({super.key, this.title, this.content});

  final String? title, content;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SpacingUnit.x1),
                color: colors.surface,
                border: Border.all(color: colors.text, width: 1),
              ),
              child: Text(
                content ?? "",
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            )),
      ],
    );
  }
}
