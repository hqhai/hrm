import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/popup_menu_calender.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

import 'form_change_month.dart';
import 'item_day_calendar.dart';

final layoutCalendarPageRoute = GoRoute(
  path: Pages.layoutCalendarPage,
  name: Pages.layoutCalendarPage,
  builder: (context, GoRouterState state) => const LayoutCalendar(),
);

class LayoutCalendar extends StatefulWidget {
  final ValueChanged<List<DateTime>>? getCurrentDate;
  final List<DateTime>? listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? item;

  const LayoutCalendar(
      {super.key,
      this.getCurrentDate,
      this.listDate,
      this.item,
      this.listItemDate});

  @override
  State<LayoutCalendar> createState() => _LayoutCalendarState();
}

class _LayoutCalendarState extends State<LayoutCalendar> {
  DateTime currentDateTime = DateTime.now();
  DateTime oldDateTime = DateTime.now();
  DateTime lastDateTime = DateTime.now();
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  List<DateTime> listDate = const [];

  ///Độ mờ khi mở popup
  bool checkOpacity = false;

  ///Loại hiển thị
  int displayType = 2;

  @override
  void initState() {
    startTime = getFirstDayOfMonth(currentDateTime);
    endTime = getLastDayOfMonth(currentDateTime);
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
    super.initState();
    _getListDate();
  }

  _upMonth() {
    setState(() {
      if (currentDateTime.month == 12) {
        currentDateTime = DateTime(currentDateTime.year + 1, 1, 1);
      } else {
        currentDateTime =
            DateTime(currentDateTime.year, currentDateTime.month + 1, 1);
      }
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
    _getListDate();
  }

  _downMonth() {
    setState(() {
      if (currentDateTime.month == 1) {
        currentDateTime = DateTime(currentDateTime.year - 1, 12, 1);
      } else {
        currentDateTime =
            DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
      }
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
    _getListDate();
  }

  _getListDate() {
    int fistDate = MenuValues.mapNumberDayInWeek[DateFormat('EEE').format(
            DateTime(currentDateTime.year, currentDateTime.month, 1))] ??
        0;
    int lastDate = MenuValues.mapNumberDayInWeek[DateFormat('EEE').format(
            DateTime(currentDateTime.year, currentDateTime.month + 1, 0))] ??
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
        oldDateTime =
            DateTime(date.year, date.month, date.day - oldDaysCount - 7);
      });
    }
    if (lastDate != 7) {
      int nextDaysCount = 7 - lastDate;
      setState(() {
        lastDateTime = DateTime(
            currentDateTime.year, currentDateTime.month + 1, 1 + nextDaysCount);
      });
    }
    if (lastDate == 0) {
      int nextDaysCount = 6 - lastDate;
      setState(() {
        lastDateTime = DateTime(
            currentDateTime.year, currentDateTime.month + 1, 1 + nextDaysCount);
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: FormChangeMonth(
          year: currentDateTime.year.toString(),
          month: currentDateTime.month.toString(),
          upMonth: () => _upMonth(),
          downMonth: () => _downMonth(),
        ),
        actions: [
          InkWell(
            onTap: () => setting(),
            child: SvgPicture.asset(
              height: SpacingUnit.x12_5,
              width: SpacingUnit.x12_5,
              Assets.images.icon.home.worksheet.worksheet2,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
          ),
          PopupMenuCalender(
            onChangeCheckOpacity: (value) => _checkOpacity(value),
            displayType: (value) => setDisplayType(value),
          )
        ],
      ),
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: ContainerScreenMain(
          padding: 0,
          margin: 0,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: SpacingUnit.x12_5,
                  width: MediaQuery.sizeOf(context).width,
                  color: colors.background,
                  child: Row(
                    children: MenuValues.mapDayInWeek.values
                        .map(
                          (e) => Expanded(
                            child: Center(
                              child: Text(
                                e,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                BodyCalendar(
                  displayType: displayType,
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
      ),
    );
  }

  setting() {
    setState(() {
      currentDateTime = DateTime.now();
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
    _getListDate();
  }

  _checkOpacity(bool value) {
    setState(() {
      checkOpacity = value;
    });
  }

  setDisplayType(int value) {
    setState(() {
      displayType = value;
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
