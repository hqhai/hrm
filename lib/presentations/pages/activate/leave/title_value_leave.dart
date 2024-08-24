import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TitleValueLeave extends StatelessWidget {
  const TitleValueLeave({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.size = SpacingUnit.x3,
    this.font = FontWeight.normal,
    this.padding = 0,
  });

  final String title, value;
  final Color? color;
  final double size, padding;
  final FontWeight font;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: colors.text,
              fontSize: size ,
              fontWeight: font,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? colors.text,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}
