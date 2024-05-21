import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTitleProfile extends StatelessWidget {
  const ItemTitleProfile({super.key, required this.title1, required this.title2, this.check = true});

  final String title1;
  final String title2;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                title1,
                style: TextStyle(color: colors.tertiary, fontSize: check ? SpacingUnit.x3 : SpacingUnit.x4),
              ),
            ),
            Expanded(
              child: Text(
                title2,
                style: TextStyle(color: colors.tertiary, fontSize: check ? SpacingUnit.x3 : SpacingUnit.x4),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x4_5,
        ),
      ],
    );
  }
}
