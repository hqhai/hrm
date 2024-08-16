import 'package:base_app/presentations/widgets/dialog/calendar_one_day/item_calander_one_day_dialog.dart';
import 'package:flutter/material.dart';

class BodyCalendarOneDateDialog extends StatefulWidget {
  final int month;
  final int year;
  final List<DateTime> listDate;
  final ValueChanged<DateTime?> setDateTime;
  final DateTime? dateTimeOld;

  const BodyCalendarOneDateDialog({
    super.key,
    required this.month,
    required this.year,
    required this.listDate,
    required this.setDateTime,
    this.dateTimeOld,
  });

  @override
  State<BodyCalendarOneDateDialog> createState() => _BodyCalendarOneDateDialogState();
}

class _BodyCalendarOneDateDialogState extends State<BodyCalendarOneDateDialog> {
  DateTime dateTime = DateTime.now();
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
    if (widget.dateTimeOld != null) {
      dateTime = widget.dateTimeOld??DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
      child: ItemCalenderOneDateDialog(
        checkOnSelect: inSelectDay(
          widget.listDate[index],
        ),
        month: widget.month,
        date: widget.listDate[index],
        isNowDate: _checkDateNow(widget.listDate[index]),
      ),
    );
  }

  bool inSelectDay(DateTime time) {
    return dateTime.isAtSameMomentAs(time);
  }

  selectDate(DateTime date) {
    setState(() {
      dateTime = date;
    });
    widget.setDateTime.call(dateTime);
  }
}
