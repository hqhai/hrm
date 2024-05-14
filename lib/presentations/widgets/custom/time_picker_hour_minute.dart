import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TimePickerHourMinute extends StatefulWidget {
  const TimePickerHourMinute({super.key, required this.onChange});

  final ValueChanged<String> onChange;

  @override
  State<TimePickerHourMinute> createState() => _TimePickerHourMinuteState();
}

class _TimePickerHourMinuteState extends State<TimePickerHourMinute> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      child: Container(
        width: SpacingUnit.x30,
        height: SpacingUnit.x12_5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xff2a6067),
            width: 2,
          ),
        ),
        child: Text(
            selectedTime != null
                ? formatHM(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
                        selectedTime!.hour, selectedTime!.minute)
                    .toString())
                : formatHM(DateTime.now().toString()),
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      onTap: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: false,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );
        setState(() {
          if (time != null) {
            setState(() {});
            selectedTime = time;
            DateTime dateTime = DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, selectedTime!.hour, selectedTime!.minute);
            widget.onChange(formatHMS(dateTime.toString()));
          } else {
            selectedTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
            widget.onChange(formatHMS(DateTime.now().toString()));
          }
        });
      },
    );
  }
}
