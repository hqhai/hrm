import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemCreateIntervalOnLeave extends StatefulWidget {
  const ItemCreateIntervalOnLeave(
      {super.key,
      this.endTimeOld,
      this.startTimeOld,
      this.error,
      this.total,
      this.startTime,
      this.endTime,
      this.title,
      required this.dayOrHours});

  final String? startTimeOld, endTimeOld;
  final ValueChanged<String>? startTime, endTime;
  final ValueChanged<int>? total;
  final String? title, error;
  final bool dayOrHours;

  @override
  State<ItemCreateIntervalOnLeave> createState() => _ItemCreateIntervalOnLeaveState();
}

class _ItemCreateIntervalOnLeaveState extends State<ItemCreateIntervalOnLeave> {
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

  /*@override
  void initState() {

    super.initState();
  }*/


  String setStartTimeOld() {
    setState(() {
      startTime = DateTime.parse(
        widget.startTimeOld ?? DateTime.now().toString(),
      );
    });
    return widget.startTimeOld??DateFormat('yyyy-MM-dd HH:mm').format(
      DateTime.now(),
    );
  }

  String setEndTimeOld() {
    setState(() {
      endTime = DateTime.parse(
        widget.endTimeOld ?? DateTime.now().toString(),
      );
    });
    return widget.endTimeOld??DateFormat('yyyy-MM-dd HH:mm').format(
      DateTime.now(),
    );
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
              child: TimePicker(
                onChange: (value) => _setStart(value),
                timeSlot: setStartTimeOld(),
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
              child: TimePicker(
                onChange: (value) => _setEnd(value),
                timeSlot: setEndTimeOld(),
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
                margin: SpacingUnit.x2,
                padding: SpacingUnit.x1,
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

  _setStart(String value) {
    setState(() {
      widget.startTime?.call(value);
      startTime = DateTime.parse(value);
      widget.total?.call(widget.dayOrHours
          ? endTime.difference(startTime).inDays
          : endTime.difference(startTime).inHours);
    });
  }

  _setEnd(String value) {
    setState(() {
      widget.endTime?.call(value);
      endTime = DateTime.parse(value);
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
