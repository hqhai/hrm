import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemAddErrorDay extends StatelessWidget {
  const ItemAddErrorDay(
      {super.key, this.errorProduct = '', this.title = '', required this.callback, this.date});

  final String errorProduct, title;
  final DateTime? date;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ContainerBorder(
                  padding: SpacingUnit.x1,
                  borderColors: colors.text.withOpacity(0.4),
                  child: GestureDetector(
                    onTap: () => callback.call(),
                    child: Center(
                      child: Text(
                        formatYMD((date ?? DateTime.now()).toString()),
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
