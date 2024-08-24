import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class TimePickerHourMinute extends StatefulWidget {
  const TimePickerHourMinute(
      {super.key, required this.onChange, required this.timeSlot, this.checkError = true});

  final ValueChanged<DateTime> onChange;
  final DateTime timeSlot;
  final bool checkError;

  @override
  State<TimePickerHourMinute> createState() => _TimePickerHourMinuteState();
}

class _TimePickerHourMinuteState extends State<TimePickerHourMinute> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () => showTimeDialog(context: context),
      child: ContainerBorder(
        borderColors: widget.checkError ? colors.outline.withOpacity(0.4) : colors.error,
        paddingVertical: SpacingUnit.x4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatHM(
                widget.timeSlot.toString(),
              ),
              style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
            ),
            SvgPicture.asset(
              Assets.images.icon.home.mingcuteTimeLine,
              colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  showTimeDialog({required BuildContext context}) async {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    DateTime timeHS = widget.timeSlot;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocalizations.setHoursAndMinutes,
                  style: TextStyle(
                    fontSize: SpacingUnit.x6,
                    color: colors.text,
                    fontWeight: FontWeight.w600
                  ),
                ),
                TimePickerSpinner(
                  alignment: Alignment.center,
                  highlightedTextStyle: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x9,
                    fontWeight: FontWeight.w600,
                  ),
                  normalTextStyle: TextStyle(
                    color: colors.text.withOpacity(0.7),
                    fontSize: SpacingUnit.x7,
                    fontWeight: FontWeight.w500,
                  ),
                  time: timeHS,
                  onTimeChange: (time) => timeHS = time,
                ),
                AppButton(
                  title: appLocalizations.apply,
                  onSubmit: () => _setTime(context: context, time: timeHS),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _setTime({required BuildContext context, required DateTime time}) {
    widget.onChange.call(time);
    dI<AppNavigation>().pop(context);
  }
}
