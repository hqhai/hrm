import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ButtonItemListRequisition extends StatelessWidget {
  const ButtonItemListRequisition({
    super.key,
    this.title = '',
    required this.callback,
    this.check = false,
    required this.colorText,
    required this.background,
  });

  final String title;
  final VoidCallback callback;
  final bool check;
  final Color colorText;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => callback.call(),
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: background,
          border: Border.all(color: colors.background, width: 1),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colorText,
            fontSize: check ? SpacingUnit.x5 : SpacingUnit.x3_5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
