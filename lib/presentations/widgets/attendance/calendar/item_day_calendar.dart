import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/item/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyCalendar extends StatefulWidget {
  final int month;
  final int year;
  final int displayType;
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
      this.listItemDate,
      required this.displayType});

  @override
  State<BodyCalendar> createState() => _BodyCalendarState();
}

class _BodyCalendarState extends State<BodyCalendar> {
  late String token;
  DateTime day = DateTime.now(), startTime = DateTime.now(), endTime = DateTime.now();
  int checkIn = 3;
  Attendance attendance = const Attendance();

  bool _checkDateNow(DateTime date) {
    DateTime dateTime = DateTime.now();
    if (dateTime.day == date.day && dateTime.month == date.month && dateTime.year == date.year) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    startTime = getFirstDayOfMonth(day);
    endTime = getLastDayOfMonth(day);
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
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
              height: MediaQuery.sizeOf(context).height * 0.81,
              child: GridView.builder(
                itemCount: widget.listDate.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.4,
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
    return ItemCalender(
      displayType: widget.displayType,
      month: widget.month,
      date: widget.listDate[index],
      isNowDate: _checkDateNow(widget.listDate[index]),
    );
  }
}
