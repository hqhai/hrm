import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemAdd extends StatelessWidget {
  const ItemAdd({super.key, this.errorProduct = '', this.title = '', required this.callback});
  final String errorProduct, title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                width: SpacingUnit.x4,
              ),
              GestureDetector(
                onTap: () => callback.call(),
                child: Icon(
                  Icons.add_circle,
                  size: SpacingUnit.x8,
                  color: colors.success,
                ),
              )
            ],
          ),
        ),
        if (errorProduct.isNotEmpty)
          Text(
            errorProduct,
            style: TextStyle(
              color: colors.error,
              fontSize: SpacingUnit.x3,
            ),
          ),
      ],
    );
  }
}
