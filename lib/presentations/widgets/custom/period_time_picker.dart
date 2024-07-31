import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/time_utils.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/calendar/layout_calendar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class PeriodTimePicker extends StatefulWidget {
  const PeriodTimePicker({
    super.key,
    required this.setStarTime,
    required this.setEndTime,
    required this.title,
    this.fontSizeTitle,
    this.fontWeightTitle,
    this.oldStarTime,
    this.oldEndTime,
  });

  final ValueChanged<DateTime?> setStarTime, setEndTime;
  final String title;
  final double? fontSizeTitle;
  final FontWeight? fontWeightTitle;
  final DateTime? oldStarTime, oldEndTime;

  @override
  State<PeriodTimePicker> createState() => _PeriodTimePickerState();
}

class _PeriodTimePickerState extends State<PeriodTimePicker> {
  DateTime? startTime, endTime;

  @override
  void initState() {
    startTime = widget.oldStarTime;
    endTime = widget.oldEndTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: SpacingUnit.x3),
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: widget.fontSizeTitle ?? SpacingUnit.x3,
                color: colors.text,
                fontWeight: widget.fontWeightTitle),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showDialogTime(context),
            child: ContainerBorder(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                showText(),
                style: TextStyle(
                  fontSize: SpacingUnit.x3,
                  color: colors.text,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String showText() {
    return startTime == null && endTime == null
        ? ''
        : startTime?.month == endTime?.month
            ? '${mapMonthName[endTime?.month]} ${startTime?.day} - ${endTime?.day}, ${startTime?.year}'
            : '${formatYMD(startTime.toString())} - ${formatYMD(endTime.toString())}';
  }

  _showDialogTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutCalendarDialog(
            endTimeOld: endTime,
            startTimeOld: startTime,
            callBackEndTime: (value) => setEndTime(value),
            callBackStartTime: (value) => setStartTime(value),
          ),
        );
      },
    );
  }

  setStartTime(DateTime? value) {
    setState(() {
      startTime = value;
      widget.setStarTime.call(startTime);
    });
  }

  setEndTime(DateTime? value) {
    setState(() {
      endTime = value;
      widget.setEndTime.call(endTime);
    });
  }
}
