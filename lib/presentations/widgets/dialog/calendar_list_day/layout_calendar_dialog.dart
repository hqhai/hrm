import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/form_change_month.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

import 'item_day_calendar_dialog.dart';

class LayoutCalendarDialog extends StatefulWidget {
  final ValueChanged<List<DateTime>>? getCurrentDate;
  final List<DateTime>? listItemDate;
  final DateTime? startTime, endTime;
  final DateTime? startTimeOld, endTimeOld;
  final ValueChanged<DateTime?> callBackStartTime, callBackEndTime;

  const LayoutCalendarDialog(
      {super.key,
      this.getCurrentDate,
      this.listItemDate,
      this.startTime,
      this.endTime,
      required this.callBackStartTime,
      required this.callBackEndTime,
      this.startTimeOld,
      this.endTimeOld});

  @override
  State<LayoutCalendarDialog> createState() => _LayoutCalendarDialogState();
}

class _LayoutCalendarDialogState extends State<LayoutCalendarDialog> {
  DateTime currentDateTime = DateTime.now();
  DateTime oldDateTime = DateTime.now();
  DateTime lastDateTime = DateTime.now();
  List<DateTime> listDate = const [];
  DateTime? startTime, endTime;

  @override
  void initState() {
    if (widget.startTimeOld != null && widget.endTimeOld != null) {
      startTime = widget.startTimeOld;
      endTime = widget.endTimeOld;
      currentDateTime = startTime!;
    }
    super.initState();
    _getListDate();
  }

  _upMonth() {
    setState(() {
      if (currentDateTime.month == 12) {
        currentDateTime = DateTime(currentDateTime.year + 1, 1, 1);
      } else {
        currentDateTime = DateTime(currentDateTime.year, currentDateTime.month + 1, 1);
      }
    });
    _getListDate();
  }

  _downMonth() {
    setState(() {
      if (currentDateTime.month == 1) {
        currentDateTime = DateTime(currentDateTime.year - 1, 12, 1);
      } else {
        currentDateTime = DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
      }
    });
    _getListDate();
  }

  _getListDate() {
    int fistDate = MenuValues.mapNumberDayInWeek[
            DateFormat('EEE').format(DateTime(currentDateTime.year, currentDateTime.month, 1))] ??
        0;
    int lastDate = MenuValues.mapNumberDayInWeek[DateFormat('EEE')
            .format(DateTime(currentDateTime.year, currentDateTime.month + 1, 0))] ??
        0;
    widget.getCurrentDate?.call(getDaysInBetween(
        DateTime(currentDateTime.year, currentDateTime.month, 1),
        DateTime(currentDateTime.year, currentDateTime.month + 1, 0)));
    if (fistDate != 8) {
      int oldDaysCount = fistDate - 2;
      DateTime date = DateTime(currentDateTime.year, currentDateTime.month, 0);
      setState(() {
        oldDateTime = DateTime(date.year, date.month, date.day - oldDaysCount);
      });
    }
    if (fistDate == 0) {
      int oldDaysCount = fistDate - 2;
      DateTime date = DateTime(currentDateTime.year, currentDateTime.month, 0);
      setState(() {
        oldDateTime = DateTime(date.year, date.month, date.day - oldDaysCount - 7);
      });
    }
    if (lastDate != 7) {
      int nextDaysCount = 7 - lastDate;
      setState(() {
        lastDateTime = DateTime(currentDateTime.year, currentDateTime.month + 1, 1 + nextDaysCount);
      });
    }
    if (lastDate == 0) {
      int nextDaysCount = 6 - lastDate;
      setState(() {
        lastDateTime = DateTime(currentDateTime.year, currentDateTime.month + 1, 1 + nextDaysCount);
      });
    }

    setState(() {
      listDate = getDaysInBetween(oldDateTime, lastDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        color: colors.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: FormChangeMonth(
                year: currentDateTime.year.toString(),
                month: currentDateTime.month.toString(),
                upMonth: () => _upMonth(),
                downMonth: () => _downMonth(),
              ),
            ),
            Container(
              height: SpacingUnit.x12_5,
              width: MediaQuery.sizeOf(context).width,
              color: colors.background,
              child: Row(
                children: MenuValues.mapDayInWeek.values
                    .map(
                      (e) => Expanded(
                        child: Center(
                          child: Text(e, style: theme.textTheme.titleMedium),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            BodyCalendarDialog(
              startTimeOld: startTime,
              endTimeOld: endTime,
              listDate: listDate,
              month: currentDateTime.month,
              year: currentDateTime.year,
              setEndTime: (value) => setEndTime(value),
              setStarTime: (value) => setStartTime(value),
            ),
            ButtonRequest(
              title1: appLocalizations.apply,
              title2: appLocalizations.cancel,
              apply: () => setApply(context),
              reject: () => setReject(context),
            ),
          ],
        ),
      ),
    );
  }

  setApply(BuildContext context) {
    widget.callBackStartTime.call(startTime);

    if (endTime == null && startTime != null) {
      final date = DateTime(startTime!.year, startTime!.month, startTime!.day, 23, 59, 59);
      widget.callBackEndTime.call(date);
    } else {
      widget.callBackEndTime.call(endTime);
    }
    dI<AppNavigation>().pop(context);
  }

  setReject(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  setStartTime(DateTime? value) {
    setState(() {
      startTime = value;
    });
  }

  setEndTime(DateTime? value) {
    setState(() {
      endTime = value;
    });
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  final int residual = days.length % 7;
  if (residual != 0) {
    days.removeRange(days.length - residual, days.length);
  }
  return days;
}
