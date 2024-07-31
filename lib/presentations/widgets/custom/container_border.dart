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
    this.circular,
    this.widthBorder,
  });

  final Widget child;
  final double? height, width, margin, padding;
  final Color? borderColors;
  final Color? backgroundColors;
  final double? circular;
  final double? widthBorder;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: margin ?? SpacingUnit.x3),
      padding: EdgeInsets.all(padding ?? SpacingUnit.x2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular ?? SpacingUnit.x2),
        color: backgroundColors,
        border: Border.all(
          color: borderColors ?? colors.text,
          width: widthBorder ?? 1,
        ),
      ),
      child: child,
    );
  }
}
