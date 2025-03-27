import 'package:base_app/common/enum/emun_time.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/time_utils.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/calendar_list_day/layout_calendar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class PeriodTimePicker extends StatefulWidget {
  const PeriodTimePicker({
    super.key,
    required this.setStarTime,
    required this.setEndTime,
    required this.title,
    this.fontSizeTitle,
    this.fontWeightTitle,
    this.oldStarTime,
    this.oldEndTime,
    this.checkTitle = false,
    this.error = '',
    this.requiredValidate = false,
  });

  final ValueChanged<DateTime?> setStarTime, setEndTime;
  final String title;
  final double? fontSizeTitle;
  final FontWeight? fontWeightTitle;
  final DateTime? oldStarTime, oldEndTime;
  final bool checkTitle;
  final String error;
  final bool requiredValidate;

  @override
  State<PeriodTimePicker> createState() => _PeriodTimePickerState();
}

class _PeriodTimePickerState extends State<PeriodTimePicker> {
  DateTime? startTime, endTime;

  @override
  void initState() {
    startTime = widget.oldStarTime;
    endTime = widget.oldEndTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        if (widget.checkTitle)
          Padding(
            padding: const EdgeInsets.only(right: SpacingUnit.x3),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(
                        fontSize: widget.fontSizeTitle ?? SpacingUnit.x3,
                        color: colors.text,
                        fontWeight: widget.fontWeightTitle),
                  ),
                  if (widget.requiredValidate)
                    TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: colors.error,
                        fontSize: widget.fontSizeTitle ?? SpacingUnit.x3,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showDialogTime(context),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.checkTitle ? SpacingUnit.x2 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContainerBorder(
                    marginTop: 0,
                    borderColors: widget.error.isNotEmpty
                        ? colors.error
                        : colors.text.withValues(alpha: 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x1),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            height: SpacingUnit.x7,
                            width: SpacingUnit.x7,
                            Assets.images.icon.home.bottomBar.calendar,
                            colorFilter: ColorFilter.mode(
                                widget.error.isNotEmpty
                                    ? colors.error
                                    : colors.text,
                                BlendMode.srcIn),
                          ),
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              showText(),
                              style: TextStyle(
                                fontSize: SpacingUnit.x4,
                                color: widget.error.isNotEmpty
                                    ? colors.error
                                    : colors.text,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            height: SpacingUnit.x7,
                            width: SpacingUnit.x7,
                            Assets.images.icon.home.dropUp,
                            colorFilter: ColorFilter.mode(
                                widget.error.isNotEmpty
                                    ? colors.error
                                    : colors.text,
                                BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.error.isNotEmpty)
                    Text(
                      widget.error,
                      style: TextStyle(
                        color: colors.error,
                        fontSize: SpacingUnit.x3,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String showText() {
    return startTime == null && endTime == null
        ? ''
        : startTime?.month == endTime?.month
            ? '${GetMonth.mapMonthName[endTime?.month]?.configMonthName} ${startTime?.day} - ${endTime?.day}, ${startTime?.year}'
            : '${formatYMD(startTime.toString())} - ${formatYMD(endTime.toString())}';
  }

  _showDialogTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutCalendarDialog(
            getCurrentDate: null,
            endTimeOld: endTime,
            startTimeOld: startTime,
            callBackEndTime: (value) => setEndTime(value),
            callBackStartTime: (value) => setStartTime(value),
          ),
        );
      },
    );
  }

  setStartTime(DateTime? value) {
    setState(() {
      startTime = value;
      widget.setStarTime.call(startTime);
    });
  }

  setEndTime(DateTime? value) {
    setState(() {
      endTime = value;
      widget.setEndTime.call(endTime);
    });
  }
}
