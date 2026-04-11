import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemUpdateProfileConstant extends StatelessWidget {
  const ItemUpdateProfileConstant({
    super.key,
    this.title = '',
    this.content = '',
    this.checkOpacity = false,
  });

  final String title, content;
  final bool checkOpacity;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.text.withValues(alpha: 0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: SpacingUnit.x1_5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x3,
              vertical: SpacingUnit.x3,
            ),
            decoration: BoxDecoration(
              color: colors.text.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
              border: Border.all(
                color: colors.text.withValues(alpha: 0.08),
              ),
            ),
            child: Text(
              content.isNotEmpty ? content : '--',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.text.withValues(alpha: checkOpacity ? 0.5 : 1),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
