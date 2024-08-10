import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class DateOverTime extends StatelessWidget {
  const DateOverTime({
    super.key,
    this.errorDate = '',
    this.dateOld,
    required this.changeValue,
  });

  final String errorDate;
  final DateTime? dateOld;
  final ValueChanged<DateTime> changeValue;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePicker(
          oldDate: dateOld,
          onChange: (value) => setDate(value),
        ),
        if (errorDate != '')
          Text(
            errorDate,
            style: TextStyle(
              color: colors.error,
              fontSize: SpacingUnit.x3,
            ),
          ),
      ],
    );
  }

  setDate(DateTime value) {
    changeValue.call(value);
  }
}
