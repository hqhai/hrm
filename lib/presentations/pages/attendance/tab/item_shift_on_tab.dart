import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemShiftOnTab extends StatelessWidget {
  const ItemShiftOnTab({
    super.key,
    required this.title,
    this.value,
    this.last,
  });

  final String title;
  final String? value;
  final bool? last;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: SpacingUnit.x2),
                child: ContainerBorder(
                  borderColors: colors.background,
                  backgroundColors: colors.blue,
                  circular: SpacingUnit.x10,
                  child: const SizedBox(
                    height: SpacingUnit.x1_5,
                    width: SpacingUnit.x1_5,
                  ),
                ),
              ),
              Text(
                value ?? appLocalizations.forgotChecking,
                style: TextStyle(
                  color: colors.blue,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ],
          ),
          if (last ?? false)
            Container(
              height: SpacingUnit.x10,
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
              child: VerticalDivider(
                color: colors.text.withOpacity(0.7),
                width: SpacingUnit.x2,
              ),
            ),
        ],
      ),
    );
  }
}
