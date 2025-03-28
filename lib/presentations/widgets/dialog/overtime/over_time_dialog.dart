import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/date_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_type_day_ot.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/location_ot.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/time_over_time.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class OverTimeAddDialog extends StatefulWidget {
  const OverTimeAddDialog({
    super.key,
    this.onChangeOverTimes,
    required this.requisitionOverTime,
    this.checkNote = true,
    required this.callBack,
    required this.checkUpdate,
  });

  final ValueChanged<RequisitionOverTime>? onChangeOverTimes;
  final RequisitionOverTime requisitionOverTime;
  final VoidCallback callBack;
  final bool checkNote, checkUpdate;

  @override
  State<OverTimeAddDialog> createState() => _OverTimeAddDialogState();
}

class _OverTimeAddDialogState extends State<OverTimeAddDialog> {
  final TextEditingController noteController = TextEditingController();
  String errorTime = '';
  DateTime date = DateTime.now();
  int startTime = 0, endTime = 0;
  int suggestTime = 0;
  String note = '';
  RequisitionOverTime requisitionOverTime = const RequisitionOverTime();
  EnumOvertimeDay typeDate = EnumOvertimeDay.holiday;
  bool isCheck = true;
  List<bool> groupValue = [true, false];
  bool checkTypeContainer = true;

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime = startTime < endTime;
    setState(() {
      errorTime = checkTime ? "" : appLocalizations.endTimeMustBeAfterStartTime;
    });
    return checkTime;
  }

  setRequisitionOverTime(RequisitionOverTime value) {
    setState(() {
      requisitionOverTime = value;
      date = value.date ?? DateTime.now();
      startTime = value.startTime;
      endTime = value.endTime;
      suggestTime = int.parse((endTime - startTime).toString());
      note = value.note;
      typeDate = value.overtimeDay;
      isCheck = value.isChecking;
    });
  }

  @override
  void initState() {
    if (widget.checkUpdate) {
      noteController.text = widget.requisitionOverTime.note;
      requisitionOverTime = widget.requisitionOverTime;
      date = widget.requisitionOverTime.date ?? DateTime.now();
      startTime = widget.requisitionOverTime.startTime;
      endTime = widget.requisitionOverTime.endTime;
      suggestTime = int.parse((endTime - startTime).toString());
      note = widget.requisitionOverTime.note;
    }
    date = widget.requisitionOverTime.date ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      paddingVertical: SpacingUnit.x4,
      marginTop: 0,
      borderColors: colors.text.withValues(alpha: 0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                checkTypeContainer
                    ? appLocalizations.date
                    : formatYMD(date.toString()),
                style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () => _setTypeContainer(),
                child: SizedBox(
                  width: SpacingUnit.x6,
                  height: SpacingUnit.x6,
                  child: SvgPicture.asset(
                    width: SpacingUnit.x6,
                    height: SpacingUnit.x6,
                    checkTypeContainer
                        ? Assets.images.icon.home.chevronForward
                        : Assets.images.icon.activateIcon.drop,
                    colorFilter: ColorFilter.mode(
                        colors.text.withValues(alpha: 0.4), BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          if (checkTypeContainer) ...[
            DateOverTime(
              dateOld: date,
              changeValue: (value) => setDate(value),
            ),
            ItemTakeOvertimeDay(
              type: typeDate,
              onChangeType: (value) => setTypeDate(value),
            ),
            LocationOverTime(
              change: (value) => _setLocation(value),
              isCheck: isCheck,
            ),
            TimeOverTime(
              requiredValidate: true,
              dateOld: secondToDateTime(time: startTime),
              changeValue: (value) => _setStart(value),
              title: appLocalizations.startTime,
            ),
            const SizedBox(
              height: SpacingUnit.x2,
            ),
            TimeOverTime(
              requiredValidate: true,
              dateOld: secondToDateTime(time: endTime),
              changeValue: (value) => _setEnd(value),
              title: appLocalizations.endTime,
            ),
            if (errorTime.isNotEmpty)
              Text(
                errorTime,
                style: TextStyle(
                  color: colors.error,
                  fontSize: SpacingUnit.x3,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${appLocalizations.totalOvertimeHours}: ',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                    TextSpan(
                      text: errorTime.isEmpty
                          ? strSeconds(((suggestTime)).toInt())
                          : '0',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.checkNote)
              ItemCreateInputArea(
                fontWeightTitle: FontWeight.w400,
                maxLines: 6,
                title: appLocalizations.note,
                error: '',
                textController: noteController,
                onChange: (value) => _setNote(value),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SpacingUnit.x4, horizontal: SpacingUnit.x1),
              child: AppButton(
                title: appLocalizations.cancel,
                onSubmit: () => widget.callBack.call(),
                color: colors.error.withValues(alpha: 0.7),
                colorText: colors.text,
              ),
            ),
          ]
        ],
      ),
    );
  }

  String strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
    checkOnClick(context);
    widget.onChangeOverTimes?.call(
      widget.requisitionOverTime.copyWith(note: value),
    );
  }

  setDate(DateTime value) {
    setState(() {
      date = value;
    });
    checkOnClick(context);
    widget.onChangeOverTimes?.call(
      widget.requisitionOverTime.copyWith(date: value),
    );
  }

  _setStart(DateTime value) {
    setState(() {
      startTime = dateTimeToSeconds(time: value);
      suggestTime = int.parse((endTime - startTime).toString());
    });
    checkOnClick(context);
    widget.onChangeOverTimes?.call(
      widget.requisitionOverTime.copyWith(
        startTime: startTime,
        suggestTime: suggestTime,
      ),
    );
  }

  _setEnd(DateTime value) {
    setState(() {
      endTime = dateTimeToSeconds(time: value);
      suggestTime = int.parse((endTime - startTime).toString());
    });
    checkOnClick(context);
    widget.onChangeOverTimes?.call(
      widget.requisitionOverTime.copyWith(
        endTime: endTime,
        suggestTime: suggestTime,
      ),
    );
  }

  setTypeDate(EnumOvertimeDay value) {
    setState(() {
      typeDate = value;
      widget.onChangeOverTimes?.call(
        widget.requisitionOverTime.copyWith(overtimeDay: value),
      );
    });
  }

  _setLocation(bool? value) {
    setState(() {
      isCheck = value ?? true;
      widget.onChangeOverTimes?.call(
        widget.requisitionOverTime.copyWith(isChecking: value),
      );
    });
  }

  _setTypeContainer() {
    setState(() {
      checkTypeContainer = !checkTypeContainer;
    });
  }
}
