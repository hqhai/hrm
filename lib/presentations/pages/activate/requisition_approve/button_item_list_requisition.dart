import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ButtonItemListRequisition extends StatelessWidget {
  const ButtonItemListRequisition({super.key, this.title = '', required this.callback, this.check = false});
  final String title;
  final VoidCallback callback;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      margin: const EdgeInsets.all(SpacingUnit.x2),
      padding: const EdgeInsets.all(SpacingUnit.x2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x1),
        color: CustomsColor.colorBackground,
        border: Border.all(color: colors.text, width: 1),
      ),
      child: Text(
        title,
        style: TextStyle(color: colors.text, fontSize: check? SpacingUnit.x4: SpacingUnit.x2_5),
      ),
    );
  }
}
