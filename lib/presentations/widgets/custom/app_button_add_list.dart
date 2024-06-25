import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ButtonAddList extends StatelessWidget {
  const ButtonAddList({
    super.key,
    this.title = '',
    required this.callBack,
  });

  final String title;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: callBack,
      child: ContainerBorder(
        height: SpacingUnit.x10,
        backgroundColors: colors.successVariant,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: SpacingUnit.x3_5,
              color: colors.background,
            ),
          ),
        ),
      ),
    );
  }
}
