import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/time_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_time_sheets.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class TimeKeepingDialog extends StatefulWidget {
  const TimeKeepingDialog({super.key, this.onChangeOverTimes, this.requisitionOverTime});

  final ValueChanged<RequisitionOverTime>? onChangeOverTimes;
  final RequisitionOverTime? requisitionOverTime;

  @override
  State<TimeKeepingDialog> createState() => _TimeKeepingDialogState();
}

class _TimeKeepingDialogState extends State<TimeKeepingDialog> {
  final TextEditingController noteController = TextEditingController();
  String date = '', errorTime = '', errorDate = '';
  int startTime = 0, endTime = 0;
  double? suggestTime;
  String? note;
  RequisitionOverTime requisitionOverTime = const RequisitionOverTime();

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDate = date.isNotEmpty;
    setState(() {
      errorDate = checkDate ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return checkDate;
  }

  setRequisitionOverTime(RequisitionOverTime value) {
    setState(() {
      requisitionOverTime = value;
      date = value.date ?? "";
      startTime = value.startTime ?? 0;
      endTime = value.endTime ?? 0;
      suggestTime = double.parse((endTime - startTime).toString());
      note = value.note;
    });
  }

  @override
  void initState() {
    noteController.text = widget.requisitionOverTime?.note ?? "";
    requisitionOverTime = widget.requisitionOverTime ?? const RequisitionOverTime();
    date = formatYMD(widget.requisitionOverTime?.date ?? '');
    startTime = widget.requisitionOverTime?.startTime ?? 0;
    endTime = widget.requisitionOverTime?.endTime ?? 0;
    suggestTime = double.parse((endTime - startTime).toString());
    note = widget.requisitionOverTime?.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemAdd(
              title: appLocalizations.date,
              callback: () => setTime(context),
              errorProduct: errorDate,
            ),
            Text(
              formatYMD(date),
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x6,
              ),
            ),
            TimeOverTime(
              dateOld: strSeconds(startTime),
              changeValue: (value) => _setStart(value),
              title: appLocalizations.startTime,
            ),
            TimeOverTime(
              dateOld: strSeconds(endTime),
              changeValue: (value) => _setEnd(value),
              title: appLocalizations.endTime,
            ),
            if (errorTime != '')
              Text(
                errorTime,
                style: TextStyle(
                  color: colors.error,
                  fontSize: SpacingUnit.x3,
                ),
              ),
            ItemCreateInput(
              title: appLocalizations.note,
              inputController: noteController,
              onChange: (value) => _setNote(value),
            ),
            ItemButtonListStationery(
              callbackCancel: () => popDialog(context),
              callbackAdd: () => setAdd(context),
            )
          ],
        ),
      ),
    );
  }

  int _timeToSeconds(String time) {
    final DateFormat format = DateFormat('HH:mm:ss');
    final DateTime t1 = format.parse(time);
    final DateTime t2 = format.parse("00:00:00");
    return t1.difference(t2).inSeconds;
  }

  String strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }

  setAdd(BuildContext context) {
    if (checkOnClick(context)) {
      widget.onChangeOverTimes?.call(RequisitionOverTime(
          date: date,
          endTime: endTime,
          startTime: startTime,
          note: note,
      ));
      Navigator.of(context).pop();
    }
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  setDate(DateTime value) {
    setState(() {
      date = formatYMD(value.toString());
    });
  }

  _setStart(String value) {
    setState(() {
      startTime = _timeToSeconds(value);
      suggestTime = double.parse((endTime - startTime).toString());
    });
  }

  _setEnd(String value) {
    setState(() {
      endTime = _timeToSeconds(value);
      suggestTime = double.parse((endTime - startTime).toString());
    });
  }

  setTime(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomTimeSheetWidget(
          onChange: (value) => setListTime(
            value,
          ),
        );
      },
    );
  }

  setListTime(RequisitionOverTime value) {
    setState(() {
      date = value.date??'';
    });
  }
}
