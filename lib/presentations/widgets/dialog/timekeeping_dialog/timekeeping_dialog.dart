import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_time_sheets.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TimeKeepingDialog extends StatefulWidget {
  final ValueChanged<RequisitionOverTime> onChange;
  final RequisitionOverTime? requisitionOverTime;

  const TimeKeepingDialog({super.key, required this.onChange, this.requisitionOverTime});

  @override
  State<TimeKeepingDialog> createState() => _TimeKeepingDialogState();
}

class _TimeKeepingDialogState extends State<TimeKeepingDialog> {
  final TextEditingController noteController = TextEditingController();
  String errorNote = '';
  RequisitionOverTime? requisitionOverTime;

  @override
  void initState() {
    if (widget.requisitionOverTime != null) {
      requisitionOverTime = widget.requisitionOverTime;
      noteController.text = widget.requisitionOverTime?.note ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4_5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Row(
              children: [
                Text(
                  appLocalizations.date,
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: colors.text,
                  ),
                ),
                const SizedBox(width: SpacingUnit.x2),
                GestureDetector(
                  onTap: () => setTime(context),
                  child: Icon(Icons.add_circle, color: colors.success, size: SpacingUnit.x7),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Text(
              formatDMY(requisitionOverTime?.date ?? ""),
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.checkIn,
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: colors.text,
                  ),
                ),
                Text(
                  strSeconds(requisitionOverTime?.startTime ?? 0),
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: colors.text,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.checkIn,
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: colors.text,
                  ),
                ),
                Text(
                  strSeconds(requisitionOverTime?.endTime ?? 0),
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: colors.text,
                  ),
                ),
              ],
            ),
          ),
          Text(
            appLocalizations.note,
            style: TextStyle(
              fontSize: SpacingUnit.x4,
              color: colors.text,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x4_5,
          ),
          AppInputArea(
            minLines: 5,
            maxLines: 5,
            placeHolder: appLocalizations.note,
            controller: noteController,
            onChange: (value) => setNote(value),
          ),
          if (errorNote.isNotEmpty)
            Text(errorNote,
                style: TextStyle(
                  fontSize: SpacingUnit.x3,
                  color: colors.error,
                )),
          const SizedBox(
            height: SpacingUnit.x4_5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _setAdd(context),
                child: Text(appLocalizations.ok),
              ),
              ElevatedButton(
                child: Text(appLocalizations.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  String strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }

  setNote(String value) {
    setState(() {
      requisitionOverTime = requisitionOverTime?.copyWith(note: value);
    });
  }

  _setAdd(BuildContext context) {
    if (requisitionOverTime != null) {
      setState(() {
        widget.onChange.call(requisitionOverTime!);
        Navigator.of(context).pop();
      });
    }
  }

  setTime(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomTimeSheetWidget(
          onChange: (value) => setListTime(
            value,
          ),
        );
      },
    );
  }

  setListTime(RequisitionOverTime value) {
    setState(() {
      requisitionOverTime = value.copyWith(note: requisitionOverTime?.note);
    });
  }
}
