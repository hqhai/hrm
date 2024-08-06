import 'package:base_app/common/utils/map_color_type.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ColorPopUp extends StatelessWidget {
  const ColorPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Divider(
          color: colors.outline,
          height: SpacingUnit.x0_25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ColorAndTitle.mapColorAndTitle(context)
              .map(
                (e) => statusNote(title: e.title, color: e.color, context: context),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget statusNote({required BuildContext context, required String title, required Color color}) {
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingUnit.x2,
          ),
          child: ContainerBorder(
            width: SpacingUnit.x3,
            height: SpacingUnit.x3,
            padding: SpacingUnit.x2,
            backgroundColors: color,
            borderColors: color,
            child: const SizedBox(),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x3_5,
          ),
        ),
      ],
    );
  }
}
