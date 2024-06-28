import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:themes/themes.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key, required this.onChange, required this.timeSlot});

  final ValueChanged<DateTime> onChange;
  final DateTime? timeSlot;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late DateTime timeValue;
  final DateTime now = DateTime.now();

  DateTime setStartTimeOld() {
    setState(() {
      timeValue = widget.timeSlot ?? now;
    });
    return timeValue;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () {
        showTimePicker(setStartTimeOld());
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xff2a6067),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(DateFormat('yyyy-MM-dd').format(setStartTimeOld()),
                style: TextStyle(fontSize: SpacingUnit.x3_5, color: colors.text)),
            Text(DateFormat('HH:mm:ss').format(setStartTimeOld()),
                style: TextStyle(fontSize: SpacingUnit.x3_5, color: colors.text)),
          ],
        ),
      ),
    );
  }

  showTimePicker(DateTime time) async {
    DateTime? dateTime = time;
    dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: time,
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    setState(() {
      dateTime != null ? timeValue = dateTime : timeValue = now;
      widget.onChange.call(timeValue);
    });
  }
}
