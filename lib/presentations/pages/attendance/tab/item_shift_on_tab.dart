import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class ItemShiftOnTab extends StatelessWidget {
  const ItemShiftOnTab({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return ContainerBorder(
      borderColors: colors.surfaceVariantHigh,
      child: Column(
        children: [
          Text(
            "${appLocalizations.shift} ${index + 1}",
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
          ContainerBorder(
            borderColors: colors.surfaceVariantHigh,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      height: SpacingUnit.x12_5,
                      width: SpacingUnit.x12_5,
                      Assets.images.icon.home.worksheet.timelineRight,
                      colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                    ),
                    Text(
                      appLocalizations.checkIn,
                      style: TextStyle(
                        color: colors.navy,
                        fontSize: SpacingUnit.x5,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
