import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class ItemShiftOnTab extends StatelessWidget {
  const ItemShiftOnTab({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    required this.color,
  });

  final String title;
  final String? value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x6, vertical: SpacingUnit.x1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingUnit.x2),
            child: CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icon,
                color: colors.text,
                size: SpacingUnit.x6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: SpacingUnit.x2_5),
            child: Text(
              value ?? appLocalizations.forgotChecking,
              style: TextStyle(
                color: color,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: SpacingUnit.x2_5),
            child: SvgPicture.asset(
              height: SpacingUnit.x1,
              width: SpacingUnit.x1,
              Assets.images.icon.home.worksheet.dot,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ],
      ),
    );
  }
}
