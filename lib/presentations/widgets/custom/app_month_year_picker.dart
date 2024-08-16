import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_time/month_year_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class MonthYearPicker extends StatefulWidget {
  const MonthYearPicker(
      {super.key, required this.onChange, this.timeOld, this.title, this.requiredValidate = false});

  final ValueChanged<DateTime> onChange;
  final DateTime? timeOld;
  final String? title;
  final bool requiredValidate;

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    if (widget.timeOld != null) {
      date = widget.timeOld!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleRequired(
              title: widget.title ?? appLocalizations.time,
              requiredValidate: widget.requiredValidate),
          GestureDetector(
            onTap: () => dialog(context),
            child: ContainerBorder(
              backgroundColors: colors.background,
              marginTop: SpacingUnit.x2,
              // padding: SpacingUnit.x4,
              borderColors: colors.text.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatYM(date.year, date.month),
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.images.icon.home.bottomBar.calendar,
                    colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
                  ),
                ],
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
            timeOld: date,
            onChange: (value) => setDate(value),
          ),
        );
      },
    );
  }
}
