import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/calendar_one_day/layout_calendar_one_day_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    this.check = true,
    required this.onChange,
    this.oldDate,
    this.checkError = true,
    this.callBack,
    this.changeType = false,
    this.typeContainer = false,
  });

  final ValueChanged<DateTime> onChange;
  final DateTime? oldDate;
  final bool check, changeType, typeContainer, checkError;
  final VoidCallback? callBack;

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

  dialog({required BuildContext context, required DateTime currentTime}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutCalendarSelectDateDialog(
            callBackDate: (value) => setDate(value),
            dateTimeOld: currentTime,
            dateTime: currentTime,
          ),
        );
      },
    );
  }

  setDate(DateTime? value) {
    setState(() {
      currentDate = value ?? DateTime.now();
      widget.onChange(currentDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () => dialog(context: context, currentTime: widget.oldDate ?? DateTime.now()),
      child: ContainerBorder(
        paddingVertical: SpacingUnit.x4_5,
        borderColors: widget.checkError ? colors.text.withOpacity(0.4) : colors.error,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatYMD(currentDate.toString()),
              style: TextStyle(
                  fontSize: SpacingUnit.x4, color: colors.text, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () => widget.callBack?.call(),
              child: SvgPicture.asset(
                height: SpacingUnit.x6,
                width: SpacingUnit.x6,
                !widget.changeType
                    ? Assets.images.icon.home.bottomBar.calendar
                    : widget.typeContainer
                        ? Assets.images.icon.activateIcon.drop
                        : Assets.images.icon.home.chevronForward,
                colorFilter: ColorFilter.mode(
                    !widget.changeType ? colors.text.withOpacity(0.4) : colors.text,
                    BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
