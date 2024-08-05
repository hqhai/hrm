import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
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
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appLocalizations.date,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: DatePicker(
                  oldDate: dateOld,
                  onChange: (value) => setDate(value),
                ),
              )
            ],
          ),
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
