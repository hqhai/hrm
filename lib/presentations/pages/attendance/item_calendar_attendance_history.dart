import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCalendarAttendanceHistory extends StatelessWidget {
  final bool isNowDate;
  final UserWorkingHistoryModel userWorkingHistoryModel;
  final int month;
  final DateTime date;
  final Widget itemDate;

  const ItemCalendarAttendanceHistory({
    super.key,
    required this.userWorkingHistoryModel,
    required this.date,
    required this.month,
    required this.itemDate,
    required this.isNowDate,
  });

  _nextItemAttendanceHistoryPage(BuildContext context,) {
    if(userWorkingHistoryModel.date != null) {
      dI<AppNavigation>().pushName(context, page: Pages.historyAttendancePage, extra: {
      'dateTime': date});
    }
  }

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(date) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => _nextItemAttendanceHistoryPage(context),
      child: Container(
        color: colors.surfaceDim,
        child: Padding(
          padding: const EdgeInsets.only(
              top: SpacingUnit.x1,
              right: SpacingUnit.x1,
              left: SpacingUnit.x1,
              bottom: SpacingUnit.x1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: _checkAttendanceEmpty() ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.spaceBetween,
            children: [
              if (isNowDate)
                Text(
                  '${appLocalizations.today} ( ${formatWeekDay(date.weekday)} - ${formatYMD(date.toString())} )',
                  style: TextStyle(
                      color: isNowDate ? colors.error : colors.text, fontSize: SpacingUnit.x3_5),
                ),
              if (!isNowDate)
                Text(
                  '${formatWeekDay(date.weekday)} - ${formatYMD(date.toString())}',
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                ),
              if (_checkAttendanceEmpty())
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.white, size: SpacingUnit.x1),
                        const SizedBox(width: SpacingUnit.x1,),
                        Text(
                          'attendance.checkIn ?? appLocalizations.noData',
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                        ),
                      ],
                    ),
                    Text(
                      appLocalizations.administrativeTime,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                    ),
                  ],
                ),
              if (_checkAttendanceEmpty())
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Colors.white, size: SpacingUnit.x1),
                        const SizedBox(width: SpacingUnit.x1,),
                        Text(
                          'attendance.checkOut ?? appLocalizations.noData',
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                        ),
                      ],
                    ),
                    Text(
                      appLocalizations.administrativeTime,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                    ),
                  ],
                ),
              if (!_checkAttendanceEmpty())
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    appLocalizations.noData,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkAttendanceEmpty(){
    return userWorkingHistoryModel.date != null;
  }
}
