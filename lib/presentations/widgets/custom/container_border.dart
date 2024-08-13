import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ContainerBorder extends StatelessWidget {
  const ContainerBorder({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.marginTop,
    this.paddingVertical,
    this.borderColors,
    this.paddingHorizontal,
    this.backgroundColors,
    this.circular,
    this.widthBorder,
  });

  final Widget child;

  final double? height, width, marginTop, paddingVertical, paddingHorizontal;
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
      margin: EdgeInsets.only(top: marginTop ?? SpacingUnit.x4),
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? SpacingUnit.x2,
          horizontal: paddingHorizontal ?? SpacingUnit.x4),
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
