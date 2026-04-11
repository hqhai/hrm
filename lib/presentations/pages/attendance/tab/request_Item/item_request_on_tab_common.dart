import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemRequestOnTabCommon extends StatefulWidget {
  const ItemRequestOnTabCommon({
    super.key,
    required this.child,
    this.checkOpacity = false,
  });

  final Widget child;
  final bool checkOpacity;

  @override
  State<ItemRequestOnTabCommon> createState() => _ItemRequestOnTabCommonState();
}

class _ItemRequestOnTabCommonState extends State<ItemRequestOnTabCommon> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return ContainerBorder(
      paddingVertical: SpacingUnit.x3,
      paddingHorizontal: SpacingUnit.x3,
      width: width,
      borderColors: colors.surfaceVariantHigh,
      child: Stack(
        children: [
          Opacity(
            opacity: widget.checkOpacity ? 1 : 0,
            child: Center(
              child: const AppLoadingIndicator(),
            ),
          ),
          Opacity(
            opacity: widget.checkOpacity ? 0.5 : 1,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
