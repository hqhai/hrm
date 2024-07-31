import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemDayOfWeek extends StatelessWidget {
  const ItemDayOfWeek(
      {super.key,
      required this.index,
      required this.time,
      required this.select});
  final bool select;
  final int index;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Container(
      width: MediaQuery.sizeOf(context).width / 7,
      height: SpacingUnit.x13,
      decoration: BoxDecoration(
          color: select ? ColorUtils.parseHex('#EAF0FF') : null,
          borderRadius: BorderRadius.circular(SpacingUnit.x2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            MenuValues.mapDayInWeek[DateFormat('EEEE').format(time)] ?? "",
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w400, color: colors.outline),
          ),
          const SizedBox(
            height: SpacingUnit.x1,
          ),
          Text(
            time.day.toString(),
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  bool check() {
    final bool checkNow =
        time.day == DateTime.now().day && time.month == DateTime.now().month;
    return checkNow;
  }
}
