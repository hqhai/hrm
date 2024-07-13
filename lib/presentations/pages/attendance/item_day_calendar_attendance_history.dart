
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/attendance/item_calendar_attendance_history.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyCalendarAttendanceHistory extends StatefulWidget {
  final int month;
  final int year;
  final Map<int, String> mapMonth;
  final Map<String, String> mapDayInWeek;
  final Map<String, int> mapNumberDayInWeek;
  final List<DateTime> listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? widget;

  const BodyCalendarAttendanceHistory(
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
  State<BodyCalendarAttendanceHistory> createState() => _BodyCalendarAttendanceHistoryState();
}

class _BodyCalendarAttendanceHistoryState extends State<BodyCalendarAttendanceHistory> {
  late String token;
  int checkIn = 3;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: width,
              height: height * 0.9,
              child: GridView.builder(
                itemCount: widget.listDate.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 1,
                    childAspectRatio: 4),
                itemBuilder: (context, index) {
                  return _item(context, index, state);
                },
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
          ],
        );
      },
    );
  }

  Widget _item(BuildContext context, int index, AttendanceState state) {
    return ItemCalendarAttendanceHistory(
      userWorkingHistoryModel: const UserWorkingHistoryModel(),
      date: widget.listDate[index],
      month: widget.month,
      itemDate: _getWidgetContent(widget.listDate[index]),
      isNowDate: _checkDateNow(widget.listDate[index]),
    );
  }
}
