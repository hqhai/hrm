import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/item/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyCalendar extends StatelessWidget {
  final int month;
  final int year;
  final int displayType;
  final Map<int, String> mapMonth;
  final Map<String, String> mapDayInWeek;
  final Map<String, int> mapNumberDayInWeek;
  final List<DateTime> listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? widget;

  const BodyCalendar({
    super.key,
    required this.month,
    required this.year,
    required this.mapMonth,
    required this.mapDayInWeek,
    required this.mapNumberDayInWeek,
    required this.listDate,
    this.widget,
    this.listItemDate,
    required this.displayType,
  });

  bool _checkDateNow(DateTime date) {
    DateTime dateTime = DateTime.now();
    if (dateTime.day == date.day &&
        dateTime.month == date.month &&
        dateTime.year == date.year) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: GridView.builder(
                itemCount: listDate.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.4,
                  crossAxisCount: 7,
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
      displayType: displayType,
      month: month,
      date: listDate[index],
      isNowDate: _checkDateNow(listDate[index]),
    );
  }
}
