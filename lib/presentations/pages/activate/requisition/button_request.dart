import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ButtonRequest extends StatelessWidget {
  const ButtonRequest({
    super.key,
    required this.reject,
    required this.apply,
    this.title1 = '',
    this.title2 = '',
  });

  final String title1, title2;
  final VoidCallback apply;
  final VoidCallback reject;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => apply.call(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.navy,
            ),
            child: Text(title1, style: TextStyle(color: colors.text)),
          ),
          ElevatedButton(
            onPressed: () => reject.call(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.navy,
            ),
            child: Text(title2, style: TextStyle(color: colors.text)),
          ),
        ],
      ),
    );
  }
}
