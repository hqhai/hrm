import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_time/month_year_dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker({super.key, required this.onChange});
  final ValueChanged<DateTime> onChange;

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${appLocalizations.time}:  ',
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          GestureDetector(
            onTap: () => dialog(context),
            child: ContainerBorder(
              child: Text(
                formatYM(date.year, date.month),
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  setDate(DateTime value) {
    setState(() {
      date = value;
      widget.onChange.call(date);
    });
  }

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: MonthYearDialog(
            onChange: (value) => setDate(value),
          ),
        );
      },
    );
  }
}
