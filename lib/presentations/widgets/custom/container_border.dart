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
    this.margin,
    this.padding,
    this.borderColors,
    this.backgroundColors,
  });

  final Widget child;
  final double? height, width, margin, padding;
  final Color? borderColors;
  final Color? backgroundColors;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: margin ?? SpacingUnit.x3),
      padding: EdgeInsets.all(padding ?? SpacingUnit.x2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: backgroundColors ?? CustomsColor.colorBackground,
        border: Border.all(
          color: borderColors ?? colors.text,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
