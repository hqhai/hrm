import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemShiftOnTab extends StatelessWidget {
  const ItemShiftOnTab({
    super.key,
    required this.title,
    this.value,
    this.last,
    this.checkInMethodEnum = CheckInMethodEnum.gPS
  });

  final String title;
  final String? value;
  final bool? last;
  final CheckInMethodEnum checkInMethodEnum;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: SpacingUnit.x2),
                  child: SvgPicture.asset(
                    Assets.images.icon.home.worksheet.dotTimeline,
                     height: SpacingUnit.x4,
                      width: SpacingUnit.x4,
                  ),
                ),
                Text(
                  value ?? appLocalizations.forgotChecking,
                  style: TextStyle(
                    color: colors.navy,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
            ),
            Text(
              checkInMethodEnum.configCheckInMethodEnumName,
              style: TextStyle(
                color: colors.navy,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ],
        ),
        if (last ?? false)
          Container(
            height: SpacingUnit.x10,
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x0_5 + SpacingUnit.x0_25),
            child: VerticalDivider(
              color: colors.text.withOpacity(0.5),
              width: SpacingUnit.x2,
            ),
          ),
      ],
    );
  }
}
