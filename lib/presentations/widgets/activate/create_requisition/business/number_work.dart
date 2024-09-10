import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class NumberWorkWidget extends StatelessWidget {
  const NumberWorkWidget({super.key, this.title = '', this.value = ''});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
          ),
          Text(
            value,
            style: TextStyle(
                color: colors.text, fontWeight: FontWeight.w600, fontSize: SpacingUnit.x4),
          ),
        ],
      ),
    );
  }
}
