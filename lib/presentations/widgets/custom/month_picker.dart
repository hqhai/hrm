import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

///BottomSheet
class DateMonthCupertino extends StatefulWidget {
  const DateMonthCupertino(
      {super.key, required this.dateOld, required this.onChange});

  final DateTime dateOld;
  final ValueChanged<DateTime> onChange;

  @override
  State<DateMonthCupertino> createState() => _DateMonthCupertinoState();
}

class _DateMonthCupertinoState extends State<DateMonthCupertino> {
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    dateTime = widget.dateOld;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          appLocalizations.setHoursAndMinutes,
          style: TextStyle(
            fontSize: SpacingUnit.x6,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: SpacingUnit.x50,
          child: CupertinoDatePicker(
            initialDateTime: widget.dateOld,
            mode: CupertinoDatePickerMode.monthYear,
            use24hFormat: false,
            showDayOfWeek: false,
            onDateTimeChanged: (DateTime newDate) => setDateTime(newDate),
          ),
        ),
        ButtonRequest(
          title1: appLocalizations.apply,
          title2: appLocalizations.cancel,
          apply: () => setApply(context),
          reject: () => setReject(context),
        ),
      ],
    );
  }

  setApply(BuildContext context) {
    widget.onChange.call(dateTime);
    dI<AppNavigation>().pop(context);
  }

  setReject(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  setDateTime(DateTime value) {
    setState(() {
      dateTime = value;
    });
  }
}

///Widget
class MonthPickerLoop extends StatefulWidget {
  const MonthPickerLoop({
    super.key,
    this.check = true,
    required this.onChange,
    this.oldDate,
    this.checkError = true,
    this.callBack,
    this.changeType = false,
    this.typeContainer = false,
    this.maxDate,
    this.title,
    this.requiredValidate = false,
  });

  final ValueChanged<DateTime> onChange;
  final DateTime? oldDate;
  final bool check, changeType, typeContainer, checkError;
  final VoidCallback? callBack;
  final DateTime? maxDate;
  final String? title;
  final bool requiredValidate;

  @override
  State<MonthPickerLoop> createState() => _DatePickerState();
}

class _DatePickerState extends State<MonthPickerLoop> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.oldDate ?? DateTime.now();
    super.initState();
  }

  dialog({required BuildContext context, required DateTime currentTime}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return DateMonthCupertino(
          onChange: (value) => setDate(value),
          dateOld: currentTime,
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
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRequired(
            title: widget.title ?? appLocalizations.time,
            requiredValidate: widget.requiredValidate),
        GestureDetector(
          onTap: () => dialog(
              context: context, currentTime: widget.oldDate ?? DateTime.now()),
          child: ContainerBorder(
            paddingVertical: SpacingUnit.x4_5,
            borderColors: widget.checkError
                ? colors.text.withValues(alpha: 0.4)
                : colors.error,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatMY(currentDate),
                  style: TextStyle(
                      fontSize: SpacingUnit.x4,
                      color: colors.text,
                      fontWeight: FontWeight.w600),
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
                        !widget.changeType
                            ? colors.text.withValues(alpha: 0.4)
                            : colors.text,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4,
        )
      ],
    );
  }
}
