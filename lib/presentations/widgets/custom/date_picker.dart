import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class DatePicker extends StatefulWidget {
  const DatePicker(
      {super.key, this.check = true, required this.onChange, this.oldDate});

  final ValueChanged<DateTime> onChange;
  final DateTime? oldDate;
  final bool check;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.oldDate ?? DateTime.now();
    super.initState();
  }

  dialog({required BuildContext context, required DateTime currentTime}) async {
    final colors = AppTheme.getColors(context);
    DateTime? time = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme(
              onSurface: colors.text,
              primary: colors.primary,
              onPrimary: colors.onPrimary,
              secondary: colors.secondary,
              brightness: Brightness.dark,
              onSecondary: colors.onSecondary,
              error: colors.error,
              onError: colors.onError,
              background: colors.background,
              onBackground: colors.onBackground,
              surface: colors.background,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      barrierColor: colors.outline.withOpacity(0.2),
      initialDate: currentTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      currentDate: DateTime.now(),
    );

    if (time != null) {
      setState(() {
        currentDate = time;
        widget.onChange(currentDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () => dialog(
          context: context, currentTime: widget.oldDate ?? DateTime.now()),
      child: ContainerBorder(
        paddingVertical: SpacingUnit.x4_5,
        borderColors: colors.text.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatYMD(currentDate.toString()),
              style: TextStyle(
                  fontSize: SpacingUnit.x4,
                  color: colors.text,
                  fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset(
              Assets.images.icon.home.bottomBar.calendar,
              colorFilter: ColorFilter.mode(
                  colors.text.withOpacity(0.4), BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
