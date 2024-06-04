import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemCreateIntervalOnLeave extends StatefulWidget {
  const ItemCreateIntervalOnLeave({super.key, this.startTime, this.endTime});

  final ValueChanged<String>? startTime, endTime;

  @override
  State<ItemCreateIntervalOnLeave> createState() => _ItemCreateIntervalOnLeaveState();
}

class _ItemCreateIntervalOnLeaveState extends State<ItemCreateIntervalOnLeave> {
  String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.intervalOnLeave,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          children: [
            Text(
              appLocalizations.startTime,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
            Container(
              width: width * 0.4,
              margin: const EdgeInsets.all(SpacingUnit.x3),
              child: TimePicker(onChange: (value) => _setStart(value), timeSlot: time),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              appLocalizations.endTime,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
            Container(
                width: width * 0.4,
                margin: const EdgeInsets.all(SpacingUnit.x3),
                child: TimePicker(onChange: (value) => _setEnd(value), timeSlot: time)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Row(
            children: [
              Text(
                appLocalizations.intervalOnLeave,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              Container(
                width: width * 0.25,
                margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3),
                padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x1),
                  color: colors.surface,
                  border: Border.all(color: colors.text, width: 1),
                ),
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
        )
      ],
    );
  }

  _setStart(String value) {
    setState(() {
      widget.startTime?.call(value);
      startTime = DateTime.parse(value);
    });
  }

  _setEnd(String value) {
    setState(() {
      widget.endTime?.call(value);
      endTime = DateTime.parse(value);
    });
  }

  int setIntervalOnLeave() {
    return endTime.difference(startTime).inHours;
  }
}
