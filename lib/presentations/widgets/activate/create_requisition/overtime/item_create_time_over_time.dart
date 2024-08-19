import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/time_picker_hour_minute.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateTimeOverTime extends StatefulWidget {
  const ItemCreateTimeOverTime(
      {super.key,
      required this.endTime,
      required this.startTime,
      this.error,
      this.total,
      required this.setStartTime,
      required this.setEndTime,
      this.title,
      required this.dayOrHours});

  final DateTime startTime, endTime;
  final ValueChanged<DateTime> setStartTime, setEndTime;
  final ValueChanged<int>? total;
  final String? title, error;
  final bool dayOrHours;

  @override
  State<ItemCreateTimeOverTime> createState() => _ItemCreateTimeOverTimeState();
}

class _ItemCreateTimeOverTimeState extends State<ItemCreateTimeOverTime> {
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

  @override
  void initState() {
    startTime = widget.startTime;
    endTime = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizations.startTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TimePickerHourMinute(
                onChange: (value) => _setStart(value),
                timeSlot: widget.startTime,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizations.endTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TimePickerHourMinute(
                timeSlot: widget.endTime,
                onChange: (value) => _setEnd(value),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x3),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: SpacingUnit.x2,
                ),
                child: Text(
                  appLocalizations.time,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
              ContainerBorder(
                width: width * 0.25,
                marginTop: SpacingUnit.x2,
                paddingVertical: SpacingUnit.x1,
                child: Center(
                  child: Text(
                    setIntervalOnLeave().toString(),
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        if (widget.error != '')
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x0_25, bottom: SpacingUnit.x3),
            child: Text(
              widget.error ?? "",
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  _setStart(DateTime value) {
    setState(() {
      widget.setStartTime.call(value);
      startTime = value;
      widget.total?.call(widget.dayOrHours
          ? endTime.difference(startTime).inDays
          : endTime.difference(startTime).inHours);
    });
  }

  _setEnd(DateTime value) {
    setState(() {
      widget.setEndTime.call(value);
      endTime = value;
      widget.total?.call(widget.dayOrHours
          ? endTime.difference(startTime).inDays
          : endTime.difference(startTime).inHours);
    });
  }

  int setIntervalOnLeave() {
    return widget.dayOrHours
        ? endTime.difference(startTime).inDays
        : endTime.difference(startTime).inHours;
  }
}
