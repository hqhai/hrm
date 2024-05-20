import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';
import 'form_change_month.dart';
import 'item_day_calendar.dart';

class LayoutCalendar extends StatefulWidget {
  final ValueChanged<List<DateTime>>? getCurrentDate;
  final List<DateTime>? listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? item;

  const LayoutCalendar(
      {super.key, this.getCurrentDate, this.listDate, this.item, this.listItemDate});

  @override
  State<LayoutCalendar> createState() => _LayoutCalendarState();
}

class _LayoutCalendarState extends State<LayoutCalendar> {
  DateTime currentDateTime = DateTime.now();
  DateTime oldDateTime = DateTime.now();
  DateTime lastDateTime = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, 1);
  List<DateTime> listDate = const [];
  String email = '';

  @override
  void initState() {
    email = dI<UserBloc>().state.user.email ?? "";
    dI<AttendanceBloc>().add(
        GetAttendanceEvent(email: email, month: currentDateTime.month, year: currentDateTime.year));
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
    dI<AttendanceBloc>().add(
        GetAttendanceEvent(email: email, month: currentDateTime.month, year: currentDateTime.year));
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
    dI<AttendanceBloc>().add(
        GetAttendanceEvent(email: email, month: currentDateTime.month, year: currentDateTime.year));
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
    if (lastDate != 7) {
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
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x4))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormChangeMonth(
                year: currentDateTime.year.toString(),
                month: MenuValues.mapMonth[currentDateTime.month] ?? "",
                upMonth: () => _upMonth(),
                downMonth: () => _downMonth(),
              ),
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width,
                color: colors.surfaceContainerLow,
                child: Row(
                    children: MenuValues.mapDayInWeek.values
                        .map((e) => Expanded(
                              child: Center(
                                  child: Text(
                                e,
                                style: theme.textTheme.titleMedium,
                              )),
                            ))
                        .toList()),
              ),
              BodyCalendar(
                widget: widget.item,
                listItemDate: widget.listItemDate,
                listDate: listDate,
                month: currentDateTime.month,
                year: currentDateTime.year,
                mapMonth: MenuValues.mapMonth,
                mapDayInWeek: MenuValues.mapDayInWeek,
                mapNumberDayInWeek: MenuValues.mapNumberDayInWeek,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}
