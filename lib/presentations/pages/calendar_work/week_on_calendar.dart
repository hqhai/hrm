import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class WeekOnCalendar extends StatelessWidget {
  const WeekOnCalendar(
      {super.key, required this.currentDateTime, required this.upWeek, required this.downWeek});

  final DateTime currentDateTime;
  final VoidCallback upWeek, downWeek;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.images.timeKeeping.calendar,
            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
          ),
          const SizedBox(
            width: SpacingUnit.x1,
          ),
          Text(
            '${appLocalizations.week} ${weekOfYear()}',
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
          ),
          const SizedBox(
            width: SpacingUnit.x1,
          ),
          Text(
            '${appLocalizations.month} ${currentDateTime.month}',
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
          ),
          InkWell(
            onTap: () => upWeek.call(),
            child: Icon(
              Icons.arrow_drop_up_sharp,
              size: SpacingUnit.x10,
              color: colors.outline,
            ),
          ),
          InkWell(
            onTap: () => downWeek.call(),
            child: Icon(
              Icons.arrow_drop_down_sharp,
              size: SpacingUnit.x10,
              color: colors.outline,
            ),
          ),
        ],
      ),
    );
  }

  int weekOfYear() {
    final startOfYear = DateTime(currentDateTime.year, 1, 1);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = currentDateTime.difference(startOfYear);
    var weekNumber = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    if(daysInFirstWeek > 3) {
      weekNumber ++;
    }
    return weekNumber;
  }
}
