import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ContainerScreenMain extends StatelessWidget {
  const ContainerScreenMain({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      margin: const EdgeInsets.all(SpacingUnit.x3),
      decoration: BoxDecoration(
        color: colors.surface,
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
