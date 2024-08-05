import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, this.check = true, required this.onChange, this.oldDate});

  final ValueChanged<DateTime> onChange;
  final DateTime? oldDate;
  final bool check;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.oldDate ?? DateTime.now();
    super.initState();
  }

  dialog({required BuildContext context, required DateTime currentTime}) async {
    final colors = AppTheme.getColors(context);
    DateTime? time = await showDatePicker(
      builder: (context, child) {
        return Theme(
           data: Theme.of(context).copyWith(
            colorScheme: ColorScheme(
              onSurface: colors.text,
              primary: colors.primary,
              onPrimary: colors.onPrimary,
              secondary:colors.secondary,
              brightness: Brightness.dark,
              onSecondary: colors.onSecondary,
              error: colors.error,
              onError: colors.onError,
              background: colors.background,
              onBackground: colors.onBackground,
              surface: colors.background,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      barrierColor: colors.outline.withOpacity(0.2),
      initialDate: currentTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
    );

    if (time != null) {
      setState(() {
        currentDate = time;
        widget.onChange(currentDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () => dialog(context: context, currentTime: widget.oldDate ?? DateTime.now()),
      child: Container(
        width: SpacingUnit.x25,
        height: SpacingUnit.x8,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SpacingUnit.x2_5,
          ),
          border: Border.all(
            color: colors.outline.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Text(
          formatYMD(currentDate.toString()),
          style: TextStyle(
              fontSize: SpacingUnit.x4, color: colors.text),
        ),
      ),
    );
  }
}
