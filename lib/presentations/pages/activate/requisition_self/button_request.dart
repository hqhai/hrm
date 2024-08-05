import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

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
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: SpacingUnit.x2,
                left: SpacingUnit.x4,
                bottom: SpacingUnit.x8,
              ),
              child: AppButton(
                onSubmit: () => apply.call(),
                title: title1,
                colorText: colors.background,
                color: colors.primary,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: SpacingUnit.x4,
                left: SpacingUnit.x2,
                bottom: SpacingUnit.x8,
              ),
              child: AppButton(
                onSubmit: () => reject.call(),
                title: title2,
                color: colors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
