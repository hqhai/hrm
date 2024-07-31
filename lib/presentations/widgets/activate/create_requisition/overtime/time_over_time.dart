import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/time_picker_hour_minute.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TimeOverTime extends StatelessWidget {
  const TimeOverTime({super.key, this.title = '', this.dateOld = '', required this.changeValue});
  final String title;
  final String dateOld;
  final ValueChanged<String> changeValue;


  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TimePickerHourMinute(
              timeSlot: dateOld,
              onChange: (value) => _setTime(value),
            ),
          ),
        ],
      ),
    );
  }

  setDate(String value) {
    changeValue.call(value);
  }

  _setTime(String value) {
    changeValue.call(value);
  }
}
