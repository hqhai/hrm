import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TitleValueLeave extends StatelessWidget {
  const TitleValueLeave({super.key, required this.title, required this.value, this.color});
  final String title, value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '$title: ',
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
              color: color?? colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ),
      ],
    );
  }
}
