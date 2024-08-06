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
    return Column(
      children: [
        Divider(
          color: colors.outline.withOpacity(0.2),
          height: SpacingUnit.x0_25,
        ),
        Container(
          color: colors.background,
          padding: EdgeInsets.all(padding ?? SpacingUnit.x3),
          margin: EdgeInsets.all(margin ?? SpacingUnit.x3),
          child: child,
        ),
      ],
    );
  }
}
