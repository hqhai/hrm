import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/time_utils.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class MonthYearDialog extends StatefulWidget {
  const MonthYearDialog({
    super.key,
    required this.onChange,
  });

  final ValueChanged<DateTime> onChange;

  @override
  State<MonthYearDialog> createState() => _MonthYearDialogState();
}

class _MonthYearDialogState extends State<MonthYearDialog> {
  DateTime time = DateTime.now();
  int year = DateTime.now().year;

  bool _checkMonthNow(int index) {
    return index + 1 == DateTime.now().month && year == DateTime.now().year;
  }

  bool _checkMonth(int index) {
    return index + 1 == time.month && year == time.year;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: colors.surfaceVariant,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => setYear(true),
                  child: Icon(
                    Icons.arrow_left,
                    color: colors.text,
                    size: SpacingUnit.x12_5,
                  ),
                ),
                const SizedBox(
                  width: SpacingUnit.x4,
                ),
                Text(
                  year.toString(),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x7,
                  ),
                ),
                const SizedBox(
                  width: SpacingUnit.x4,
                ),
                InkWell(
                  onTap: () => setYear(false),
                  child: Icon(
                    Icons.arrow_right,
                    color: colors.text,
                    size: SpacingUnit.x12_5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: mapMonth.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setTimeMonth(index + 1),
                child: ContainerBorder(
                  backgroundColors: _checkMonth(index) ? colors.error : null,
                  borderColors: _checkMonthNow(index) ? colors.blue : colors.surface,
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      mapMonth[index + 1].toString(),
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => cancel(context),
                child: Text(
                  appLocalizations.cancel,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x7,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => ok(context),
                child: Text(
                  appLocalizations.ok,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x7,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  setYear(bool check) {
    setState(() {
      if (check) {
        year--;
      } else {
        year++;
      }
    });
  }

  cancel(BuildContext context) {
    popDialog(context);
  }

  ok(BuildContext context) {
    setState(() {
      time = time = DateTime(year, time.month);
      widget.onChange.call(time);
    });
    popDialog(context);
  }

  setTimeMonth(int month) {
    setState(() {
      time = DateTime(year, month);
    });
  }
}
