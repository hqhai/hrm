import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/form_change_month_2.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/item_day_calendar_2.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class LayoutCalendar2 extends StatefulWidget {
  final ValueChanged<List<DateTime>>? getCurrentDate;
  final List<DateTime>? listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? item;

  const LayoutCalendar2(
      {super.key, this.getCurrentDate, this.listDate, this.item, this.listItemDate});

  @override
  State<LayoutCalendar2> createState() => _LayoutCalendar2State();
}

class _LayoutCalendar2State extends State<LayoutCalendar2> {
  DateTime currentDateTime = DateTime.now();
  DateTime oldDateTime = DateTime.now();
  DateTime lastDateTime = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, 1);
  List<DateTime> listDate = const [];
  String id = '';
  bool checkTypeCalender = false;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  void initState() {
    startTime = getFirstDayOfMonth(currentDateTime);
    endTime = getLastDayOfMonth(currentDateTime);
    dI<NotesBloc>().add(
        GetNotesEvent(startDate: startTime.toString(), endDate: endTime.toString()));
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
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    dI<NotesBloc>().add(
        GetNotesEvent(startDate: startTime.toString(), endDate: endTime.toString()));
    _getListDate();
  }

  _downMonth() {
    setState(() {
      if (currentDateTime.month == 1) {
        currentDateTime = DateTime(currentDateTime.year - 1, 12, 1);
      } else {
        currentDateTime = DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
      }
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    dI<NotesBloc>().add(
        GetNotesEvent(startDate: startTime.toString(), endDate: endTime.toString()));
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
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            color: colors.background,
            borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x4))),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormChangeMonth2(
                onChange: (value) => _setTypeCalender(value),
                year: currentDateTime.year.toString(),
                month: MenuValues.mapMonth[currentDateTime.month] ?? "",
                upMonth: () => _upMonth(),
                downMonth: () => _downMonth(),
              ),
              BodyCalendar2(
                checkTypeCalender: checkTypeCalender,
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

  _setTypeCalender(bool value) {
    setState(() {
      checkTypeCalender = value;
    });
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

