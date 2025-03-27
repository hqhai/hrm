import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class TimePickerHourMinute extends StatefulWidget {
  const TimePickerHourMinute(
      {super.key,
      required this.onChange,
      required this.timeSlot,
      this.checkError = true});

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
        borderColors: widget.checkError
            ? colors.outline.withValues(alpha: 0.4)
            : colors.error,
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
              colorFilter: ColorFilter.mode(
                  colors.text.withValues(alpha: 0.4), BlendMode.srcIn),
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
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalizations.setHoursAndMinutes,
                style: TextStyle(
                    fontSize: SpacingUnit.x5,
                    color: colors.text,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: SpacingUnit.x50,
                child: CupertinoDatePicker(
                  initialDateTime: timeHS,
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newDate) => timeHS = newDate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: AppButton(
                  colorText: colors.background,
                  color: colors.blue,
                  title: appLocalizations.apply,
                  onSubmit: () => _setTime(context: context, time: timeHS),
                ),
              ),
            ],
          );
        });
  }

  _setTime({required BuildContext context, required DateTime time}) {
    widget.onChange.call(time);
    dI<AppNavigation>().pop(context);
  }
}
