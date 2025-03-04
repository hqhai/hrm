import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequestInformationTitleValue extends StatelessWidget {
  const RequestInformationTitleValue({
    super.key,
    required this.title,
    required this.value,
    this.size,
  });

  final String title, value;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: size ?? SpacingUnit.x3,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: size ?? SpacingUnit.x3,
            ),
          ),
        ],
      ),
    );
  }
}
