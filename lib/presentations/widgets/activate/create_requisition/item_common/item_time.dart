import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTime extends StatelessWidget {
  const ItemTime({super.key, required this.title, required this.setTime, required this.timeOld});

  final String title;
  final ValueChanged<DateTime> setTime;
  final DateTime timeOld;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          TimePicker(
            checkType: false,
            onChange: (value) => setTime.call(value),
            timeSlot: timeOld,
          ),
        ],
      ),
    );
  }
}
