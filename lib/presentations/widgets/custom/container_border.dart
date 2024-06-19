import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ContainerBorder extends StatelessWidget {
  const ContainerBorder({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  final Widget child;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      padding: const EdgeInsets.all(SpacingUnit.x3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: CustomsColor.colorBackground,
        border: Border.all(
          color: colors.text,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
