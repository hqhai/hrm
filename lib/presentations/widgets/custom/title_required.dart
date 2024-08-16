import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TitleRequired extends StatelessWidget {
  const TitleRequired({super.key, required this.title, this.requiredValidate = false});
  final String title;
  final bool requiredValidate;


  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (requiredValidate)
            TextSpan(
              text: "*",
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x4,
              ),
            ),
        ],
      ),
    );
  }
}
