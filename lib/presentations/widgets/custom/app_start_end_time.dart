import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/time_over_time.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class AppStartEndTime extends StatefulWidget {
  final String title1, title2, title3;
  final String errorTime;
  final int startTime, endTime;
  final double numberValue;
  final ValueChanged<int> setStartTime, setEndTime;
  final bool checkNumberValue;

  const AppStartEndTime({
    super.key,
    this.title1 = '',
    this.title2 = '',
    this.title3 = '',
    this.startTime = 0,
    this.endTime = 0,
    this.numberValue = 0,
    this.errorTime = '',
    required this.setStartTime,
    required this.setEndTime,
    this.checkNumberValue = true,
  });

  @override
  State<AppStartEndTime> createState() => _AppStartEndTimeState();
}

class _AppStartEndTimeState extends State<AppStartEndTime> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SpacingUnit.x4,
        ),
        ContainerBorder(
          borderColors: colors.outline.withOpacity(0.4),
          paddingHorizontal: SpacingUnit.x4,
          paddingVertical: SpacingUnit.x4,
          child: TimeOverTime(
            checkError: widget.errorTime.isEmpty,
            requiredValidate: true,
            dateOld: secondToDateTime(time: widget.startTime),
            changeValue: (value) => _setStartTime(
              value: value,
            ),
            title: widget.title1,
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4,
        ),
        ContainerBorder(
          borderColors: colors.outline.withOpacity(0.4),
          paddingHorizontal: SpacingUnit.x4,
          paddingVertical: SpacingUnit.x4,
          child: TimeOverTime(
            checkError: widget.errorTime.isEmpty,
            requiredValidate: true,
            dateOld: secondToDateTime(time: widget.endTime),
            changeValue: (value) => _setEndTime(
              value: value,
            ),
            title: widget.title2,
          ),
        ),
        if (!widget.checkNumberValue && widget.errorTime.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
            child: Text(
              widget.errorTime,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
        if (widget.checkNumberValue)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
            child: Text.rich(
              TextSpan(
                children: [
                  if (widget.errorTime.isNotEmpty)
                    TextSpan(
                      text: widget.errorTime,
                      style: TextStyle(
                        color: colors.error,
                        fontSize: SpacingUnit.x3,
                      ),
                    ),
                  if (widget.errorTime.isEmpty) ...[
                    TextSpan(
                      text: '${widget.title3}: ',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                    TextSpan(
                      text: widget.errorTime.isEmpty ? strSeconds(widget.numberValue.toInt()) : '0',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }

  _setEndTime({required DateTime value}) {
    widget.setEndTime.call(dateTimeToSeconds(time: value));
  }

  _setStartTime({required DateTime value}) {
    widget.setStartTime.call(dateTimeToSeconds(time: value));
  }
}
