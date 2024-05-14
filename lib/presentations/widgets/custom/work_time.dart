import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/time_picker_hour_minute.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class WorkTime extends StatefulWidget {
  const WorkTime(
      {super.key,
      required this.onChangeMorningStartTime,
      required this.onChangeMorningEndTime,
      required this.onChangeAfternoonStartTime,
      required this.onChangeAfternoonEndTime});

  final ValueChanged<String> onChangeMorningStartTime;
  final ValueChanged<String> onChangeMorningEndTime;
  final ValueChanged<String> onChangeAfternoonStartTime;
  final ValueChanged<String> onChangeAfternoonEndTime;

  @override
  State<WorkTime> createState() => _WorkTimeState();
}

class _WorkTimeState extends State<WorkTime> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: SpacingUnit.x2),
        Text(appLocalizations.morningStartTime,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
        const SizedBox(height: SpacingUnit.x2),
        TimePickerHourMinute(
          onChange: (value) => widget.onChangeMorningStartTime(value),
        ),
        const SizedBox(height: SpacingUnit.x2),
        Text(appLocalizations.morningEndTime,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
        const SizedBox(height: SpacingUnit.x2),
        TimePickerHourMinute(
          onChange: (value) => widget.onChangeMorningEndTime(value),
        ),
        const SizedBox(height: SpacingUnit.x2),
        Text(appLocalizations.afternoonStartTime,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
        const SizedBox(height: SpacingUnit.x2),
        TimePickerHourMinute(
          onChange: (value) => widget.onChangeAfternoonStartTime(value),
        ),
        const SizedBox(height: SpacingUnit.x2),
        Text(appLocalizations.afternoonEndTime,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
        const SizedBox(height: SpacingUnit.x2),
        TimePickerHourMinute(
          onChange: (value) => widget.onChangeAfternoonEndTime(value),
        ),
      ],
    );
  }
}
