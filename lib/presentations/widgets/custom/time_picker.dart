import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:themes/themes.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key, required this.onChange, required this.timeSlot});
  final ValueChanged<String> onChange;
  final String timeSlot;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late DateTime timeValue;
  DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm');



  DateTime setStartTimeOld() {
    setState(() {
      if(widget.timeSlot != '') {
        timeValue = inputFormat.parse(widget.timeSlot);
      }
      else{
        timeValue = DateTime.now();
      }
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
            Text(DateFormat('yyyy-MM-dd').format(_ruleTime(setStartTimeOld())),
                style: TextStyle(fontSize: 14, color: colors.text)),
            Text(DateFormat('HH:mm:ss').format(_ruleTime(setStartTimeOld())),
                style: TextStyle(fontSize: 14, color: colors.text)),
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
      dateTime != null ? timeValue = dateTime : timeValue = DateTime.now();
      widget.onChange.call(DateFormat('yyyy-MM-dd HH:mm:ss').format(_ruleTime(timeValue)));
    });
  }
  
  DateTime _ruleTime(DateTime time){
    if(time.hour <= 12 && widget.timeSlot == 'S'){
      return DateTime(time.year, time.month, time.day, 8, 30, 0);
    }
    else if(time.hour <= 12 && widget.timeSlot == 'E'){
      return DateTime(time.year, time.month, time.day, 12, 0, 0);
    }
    else if(time.hour > 12 && widget.timeSlot == 'S'){
      return DateTime(time.year, time.month, time.day, 13, 0, 0);
    }
    else if(time.hour > 12 && widget.timeSlot == 'E'){
      return DateTime(time.year, time.month, time.day, 18, 20, 0);
    }
    else{
      return time;
    }
  }
}
