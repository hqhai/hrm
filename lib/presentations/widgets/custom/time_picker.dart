import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:themes/themes.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.onChange,
    required this.timeSlot,
    this.checkType = true,
  });

  final ValueChanged<DateTime> onChange;
  final DateTime? timeSlot;
  final bool checkType;

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
        height: SpacingUnit.x14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
          border: Border.all(
            color: colors.text.withValues(alpha: 0.3),
            width: SpacingUnit.x0_25,
          ),
        ),
        child: widget.checkType
            ? Column(
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy').format(setStartTimeOld()),
                    style:
                        TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                  ),
                  Text(
                    DateFormat('HH:mm').format(setStartTimeOld()),
                    style:
                        TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(setStartTimeOld()),
                          style: TextStyle(
                              fontSize: SpacingUnit.x4, color: colors.text),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: SpacingUnit.x4),
                          child: Text(
                            DateFormat('HH:mm').format(setStartTimeOld()),
                            style: TextStyle(
                                fontSize: SpacingUnit.x4, color: colors.text),
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      Assets.images.icon.home.bottomBar.calendar,
                      colorFilter: ColorFilter.mode(
                        colors.text.withValues(alpha: 0.3),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  showTimePicker(DateTime time) async {
    final colors = AppTheme.getColors(context);
    DateTime? dateTime = time;
    dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: time,
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      theme: Theme.of(context).copyWith(
        colorScheme: ColorScheme(
          onSurface: colors.text,
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          secondary: colors.secondary,
          brightness: Brightness.dark,
          onSecondary: colors.onSecondary,
          error: colors.error,
          onError: colors.onError,
          surface: colors.background,
        ),
      ),
      is24HourMode: true,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x3)),
      constraints: const BoxConstraints(
        maxWidth: SpacingUnit.x87,
        maxHeight: SpacingUnit.x100 + SpacingUnit.x62,
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
    );
    setState(() {
      dateTime != null ? timeValue = dateTime : timeValue = now;
      widget.onChange.call(timeValue);
    });
  }
}
