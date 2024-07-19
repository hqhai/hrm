import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/attendance/form_change_month_attendance_history.dart';
import 'package:base_app/presentations/pages/attendance/item_day_calendar_attendance_history.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final layoutCalendarAttendanceHistoryPageRoute = GoRoute(
    path: Pages.layoutCalendarAttendanceHistoryPage,
    name: Pages.layoutCalendarAttendanceHistoryPage,
    builder: (context, GoRouterState state) => const LayoutCalendarAttendanceHistory());

class LayoutCalendarAttendanceHistory extends StatefulWidget {
  final ValueChanged<List<DateTime>>? getCurrentDate;
  final List<DateTime>? listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? item;

  const LayoutCalendarAttendanceHistory(
      {super.key, this.getCurrentDate, this.listDate, this.item, this.listItemDate});

  @override
  State<LayoutCalendarAttendanceHistory> createState() => _LayoutCalendarAttendanceHistoryState();
}

class _LayoutCalendarAttendanceHistoryState extends State<LayoutCalendarAttendanceHistory> {
  DateTime currentDateTime = DateTime.now();
  DateTime oldDateTime = DateTime.now();
  DateTime lastDateTime = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, 1);
  List<DateTime> listDate = const [];
  String id = '';

  @override
  void initState() {
    id = dI<UserBloc>().state.user.id;
    dI<AttendanceBloc>().add(
        GetWorkSheetEvent(startTime: currentDateTime, endTime: currentDateTime));
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
        GetWorkSheetEvent(startTime: currentDateTime, endTime: currentDateTime));
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
        GetWorkSheetEvent(startTime: currentDateTime, endTime: currentDateTime));
    _getListDate();
  }

  _getListDate() {
    widget.getCurrentDate?.call(getDaysInBetween(
        DateTime(currentDateTime.year, currentDateTime.month, 1),
        DateTime(currentDateTime.year, currentDateTime.month + 1, 0)));
    DateTime date = DateTime(currentDateTime.year, currentDateTime.month, 0);
    setState(() {
      oldDateTime = DateTime(date.year, date.month+1, 1);
      lastDateTime = DateTime(currentDateTime.year, currentDateTime.month+1, 0);
      listDate = getDaysInBetween(oldDateTime, lastDateTime);
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x4))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormChangeMonthAttendanceHistory(
                year: currentDateTime.year.toString(),
                month: MenuValues.mapMonth[currentDateTime.month] ?? "",
                upMonth: () => _upMonth(),
                downMonth: () => _downMonth(),
              ),
              BodyCalendarAttendanceHistory(
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

