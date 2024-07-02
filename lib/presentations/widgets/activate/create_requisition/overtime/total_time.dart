import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TotalTime extends StatelessWidget {
  const TotalTime({super.key, this.content = '', this.title = ''});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: SpacingUnit.x3_5,
            color: colors.text,
            fontWeight: FontWeight.w800
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: SpacingUnit.x3_5,
            color: colors.text,
          ),
        ),
      ],
    );
  }
}
