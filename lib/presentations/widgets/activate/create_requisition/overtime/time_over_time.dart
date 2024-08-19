import 'package:base_app/presentations/widgets/custom/time_picker_hour_minute.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';

class TimeOverTime extends StatelessWidget {
  const TimeOverTime(
      {super.key,
      this.title = '',
      required this.dateOld,
      required this.changeValue,
      this.requiredValidate = false});

  final String title;
  final DateTime dateOld;
  final ValueChanged<DateTime> changeValue;
  final bool requiredValidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRequired(
          title: title,
          requiredValidate: requiredValidate,
        ),
        TimePickerHourMinute(
          timeSlot: dateOld,
          onChange: (value) => _setTime(value),
        ),
      ],
    );
  }

  _setTime(DateTime value) {
    changeValue.call(value);
  }
}
