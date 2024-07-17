import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themes/themes.dart';

class BodyCalendar extends StatefulWidget {
  final int month;
  final int year;
  final Map<int, String> mapMonth;
  final Map<String, String> mapDayInWeek;
  final Map<String, int> mapNumberDayInWeek;
  final List<DateTime> listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? widget;

  const BodyCalendar(
      {super.key,
      required this.month,
      required this.year,
      required this.mapMonth,
      required this.mapDayInWeek,
      required this.mapNumberDayInWeek,
      required this.listDate,
      this.widget,
      this.listItemDate});

  @override
  State<BodyCalendar> createState() => _BodyCalendarState();
}

class _BodyCalendarState extends State<BodyCalendar> {
  late String token;
  DateTime day = DateTime.now();
  int checkIn = 3;
  Attendance attendance = const Attendance(attendanceDate: '');

  Widget _getWidgetContent(DateTime date) {
    if (widget.widget == null) return const SizedBox();
    return widget.widget?[date] ?? Container();
  }

  bool _checkDateNow(DateTime date) {
    DateTime dateTime = DateTime.now();
    if (dateTime.day == date.day && dateTime.month == date.month && dateTime.year == date.year) {
      return true;
    }
    return false;
  }

  int _checkAttendance(List<Attendance> attendances, DateTime date, int month) {
    List<String> attendanceDates = attendances.map((e) => e.attendanceDate.toString()).toList();
    int index = attendanceDates.indexWhere((e) {
      DateTime dateTime = DateTime.parse(e);
      return dateTime.month == month && dateTime.day == date.day && month == date.month;
    });
    return index != -1 ? index : -1;
  }

  // 1: muộn, 2: đúng giờ, 3: không chấm công, 4: về sớm,
  int _checkCheckIn(List<Attendance> attendances, DateTime date, int month) {
    int index = _checkAttendance(attendances, date, month);
    if (index == -1) {
      return 3;
    } else if (attendances[index].checkIn == null) {
      return 1;
    } else if (attendances[index].checkOut == null) {
      return 4;
    } else {
      List<String> timePartsIn = formatHMByH(attendances[index].checkIn ?? "").split(':');
      List<String> timePartsOut = formatHMByH(attendances[index].checkOut ?? "").split(':');
      int hourIn = int.parse(timePartsIn[0]);
      int minuteIn = int.parse(timePartsIn[1]);
      int hourOut = int.parse(timePartsOut[0]);
      int minuteOut = int.parse(timePartsOut[1]);
      return (hourIn > 8 || (hourIn == 8 && minuteIn > 30))
          ? 1
          : (hourOut < 18 || (hourOut == 18 && minuteOut < 20))
              ? 4
              : 2;
    }
  }

  @override
  void initState() {
    super.initState();
    dI<AttendanceBloc>().add(GetAttendanceEvent(
        id: dI<UserBloc>().state.user.id, month: widget.month, year: widget.year));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: MediaQuery.sizeOf(context).width,
              height: widget.listDate.length < 42
                  ? MediaQuery.sizeOf(context).height * 4.7 / 7
                  : MediaQuery.sizeOf(context).height * 6 / 7,
              child: GridView.builder(
                itemCount: widget.listDate.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.5,
                  crossAxisCount: 7,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return _item(context, index, state);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _item(BuildContext context, int index, AttendanceState state) {
    return _Item(
      date: widget.listDate[index],
      month: widget.month,
      checkIn: _checkCheckIn(state.attendances, widget.listDate[index], widget.month),
      attendanceIndex: _checkAttendance(state.attendances, widget.listDate[index], widget.month),
      attendance: _checkAttendance(state.attendances, widget.listDate[index], widget.month) != -1
          ? state.attendances[
              _checkAttendance(state.attendances, widget.listDate[index], widget.month)]
          : const Attendance(attendanceDate: ''),
      itemDate: _getWidgetContent(widget.listDate[index]),
      isNowDate: _checkDateNow(widget.listDate[index]),
    );
  }
}

class _Item extends StatelessWidget {
  final bool isNowDate;
  final Attendance attendance;
  final int month;
  final int checkIn;
  final int attendanceIndex;
  final DateTime date;
  final Widget itemDate;

  const _Item({
    required this.attendance,
    required this.checkIn,
    required this.attendanceIndex,
    required this.date,
    required this.month,
    required this.itemDate,
    required this.isNowDate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _nextItemAttendanceHistoryPage(context),
      child: Container(
        color: colors.surfaceDim,
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(
              top: SpacingUnit.x1,
              right: SpacingUnit.x1,
              left: SpacingUnit.x1,
              bottom: SpacingUnit.x1),
          child: CircleAvatar(
            backgroundColor: isNowDate ? colors.primary : Colors.transparent,
            child: Text(
              date.day.toString(),
              style: theme.textTheme.titleLarge!.copyWith(color: _color(context)),
            ),
          ),
        ),
      ),
    );
  }

  Color _color(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return month != date.month
        ? colors.neutralVariant40
        : (checkIn == 1
            ? colors.error
            : (checkIn == 2
                ? Colors.green
                : checkIn == 4
                    ? colors.error
                    : colors.text));
  }
  _nextItemAttendanceHistoryPage(BuildContext context,) {
    if(attendance.attendanceDate != '') {
      dI<AppNavigation>().pushName(context, page: Pages.historyAttendancePage, extra: {
        'attendance': attendance});
    }
  }

}
