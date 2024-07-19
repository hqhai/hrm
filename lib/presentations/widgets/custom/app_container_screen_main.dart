import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ContainerScreenMain extends StatelessWidget {
  const ContainerScreenMain({super.key, required this.child, this.padding, this.margin});

  final double? padding, margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      padding: EdgeInsets.all(padding ?? SpacingUnit.x3),
      margin: EdgeInsets.all(margin ?? SpacingUnit.x3),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
        border: Border.all(
          width: 1,
          color: colors.surface,
        ),
      ),
      child: child,
    );
  }
}
