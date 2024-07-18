import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_link_next_screen.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTypeOnTab extends StatelessWidget {
  const ItemTypeOnTab({super.key, required this.type, required this.callback});

  final String type;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            type,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: AppLinkNextScreen(
            callback: () => callback.call(),
          ),
        )
      ],
    );
  }
}
