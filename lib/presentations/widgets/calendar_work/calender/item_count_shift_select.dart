import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCountShiftSelect extends StatelessWidget {
  final int countShift;
  final bool checkSelect;
  final VoidCallback callBack;

  const ItemCountShiftSelect({
    super.key,
    required this.countShift,
    required this.checkSelect,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding:
          const EdgeInsets.only(left: SpacingUnit.x5, right: SpacingUnit.x8),
      alignment: Alignment.centerLeft,
      height: SpacingUnit.x10,
      width: width,
      color: colors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${appLocalizations.youAreSelecting} ',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                TextSpan(
                  text: countShift.toString(),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: " ${appLocalizations.timeWorking}",
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
              side: const BorderSide(color: Color(0xff585858)),
              value: checkSelect,
              onChanged: (value) => callBack.call()),
        ],
      ),
    );
  }
}
