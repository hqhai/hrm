import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemWorkSheet extends StatelessWidget {
  const ItemWorkSheet({super.key, this.title = '', this.value = ''});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return SizedBox(
      height: SpacingUnit.x13,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(SpacingUnit.x5),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: colors.surfaceVariantHigh,
                    width: 0.5,
                  ),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            color: colors.surfaceVariantHigh,
            height: SpacingUnit.x16,
          ),
          Expanded(
            child: Container(
              // padding: const EdgeInsets.all(SpacingUnit.x5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: colors.surfaceVariantHigh,
                    width: 0.5,
                  ),
                ),
              ),
              child: Text(
                value,
                style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
