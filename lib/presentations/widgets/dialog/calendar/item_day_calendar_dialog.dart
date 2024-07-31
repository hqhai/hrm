import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/presentations/widgets/dialog/calendar/item_calander_dialog.dart';
import 'package:flutter/material.dart';

class BodyCalendarDialog extends StatefulWidget {
  final int month;
  final int year;
  final List<DateTime> listDate;
  final ValueChanged<DateTime?> setStarTime, setEndTime;
  final DateTime? startTimeOld, endTimeOld;

  const BodyCalendarDialog({
    super.key,
    required this.month,
    required this.year,
    required this.listDate,
    required this.setStarTime,
    required this.setEndTime,
    this.startTimeOld,
    this.endTimeOld,
  });

  @override
  State<BodyCalendarDialog> createState() => _BodyCalendarDialogState();
}

class _BodyCalendarDialogState extends State<BodyCalendarDialog> {
  DateTime day = DateTime.now();
  DateTime? startTime, endTime;
  bool check = true;


  bool _checkDateNow(DateTime date) {
    DateTime dateTime = DateTime.now();
    if (dateTime.day == date.day && dateTime.month == date.month && dateTime.year == date.year) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    if (widget.startTimeOld != null && widget.endTimeOld != null) {
      startTime = widget.startTimeOld;
      endTime = widget.endTimeOld;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).width * 0.7,
          child: GridView.builder(
            itemCount: widget.listDate.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              return _item(context, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    int index,
  ) {
    return InkWell(
      onTap: () => selectDate(
        widget.listDate[index],
      ),
      child: ItemCalenderDialog(
        checkEnd: check,
        checkOnSelect: inSelectDay(
          widget.listDate[index],
        ),
        checkEndSelectDay: selectEndDay(
          widget.listDate[index],
        ),
        checkStartSelectDay: selectStartDay(
          widget.listDate[index],
        ),
        month: widget.month,
        date: widget.listDate[index],
        isNowDate: _checkDateNow(widget.listDate[index]),
      ),
    );
  }

  bool selectStartDay(DateTime time) {
    bool start = isAtSameMomentAsDay(start: startTime, end: time);
    return start;
  }

  bool selectEndDay(DateTime time) {
    bool end = isAtSameMomentAsDay(start: endTime, end: time);
    return end;
  }

  bool inSelectDay(DateTime time) {
    bool start = startTime?.isBefore(time) ?? false;
    bool end = endTime?.isAfter(DateTime(time.year, time.month, time.day, 23, 59, 59)) ?? false;
    return start && end;
  }

  selectDate(DateTime date) {
    setState(() {
      if (check) {
        startTime = date;
        check = false;
        endTime = null;
        swap(start: startTime, end: endTime);
      } else {
        endTime = DateTime(date.year, date.month, date.day, 23, 59, 59);
        check = true;
        swap(start: startTime, end: endTime);
      }
    });
    widget.setEndTime.call(endTime);
    widget.setStarTime.call(startTime);
  }

  swap({DateTime? start, DateTime? end}) {
    if (end?.isBefore(start!) ?? false) {
      setState(() {
        startTime = end;
        endTime = start;
      });
    }
  }
}
