import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemCreateBusinessDay extends StatefulWidget {
  const ItemCreateBusinessDay({super.key, this.startTime, this.endTime, this.title, required this.dayOrHours});

  final ValueChanged<String>? startTime, endTime;
  final String? title;
  final bool dayOrHours;

  @override
  State<ItemCreateBusinessDay> createState() => _ItemCreateBusinessDayState();
}

class _ItemCreateBusinessDayState extends State<ItemCreateBusinessDay> {
  String time = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
          widget.title ?? "",
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
              child: DatePicker(onChange: (value) => _setStart(value), oldDate: time),
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
                child: DatePicker(onChange: (value) => _setEnd(value), oldDate: time)),
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
    return widget.dayOrHours
        ? endTime.difference(startTime).inDays
        : endTime.difference(startTime).inHours;
  }
}
