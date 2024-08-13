import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_common/item_time.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateTimeStartAndEnd extends StatefulWidget {
  const ItemCreateTimeStartAndEnd(
      {super.key,
      this.endTimeOld,
      this.startTimeOld,
      this.error,
      this.total,
      this.startTime,
      this.endTime,
      this.title,
      this.leave = false,
      required this.dayOrHours,
      this.title1,
      this.title2,
      this.title3});

  final DateTime? startTimeOld, endTimeOld;
  final ValueChanged<DateTime>? startTime, endTime;
  final ValueChanged<double>? total;
  final String? title, title1, title2, title3, error;
  final bool dayOrHours, leave;

  @override
  State<ItemCreateTimeStartAndEnd> createState() =>
      _ItemCreateTimeStartAndEndState();
}

class _ItemCreateTimeStartAndEndState extends State<ItemCreateTimeStartAndEnd> {
  final DateTime now = DateTime.now();
  DateTime startTime = DateTime.now(), endTime = DateTime.now();

  DateTime setStartTimeOld() {
    setState(() {
      startTime = widget.startTimeOld ?? now;
    });
    return startTime;
  }

  DateTime setEndTimeOld() {
    setState(() {
      endTime = widget.endTimeOld ?? now;
    });
    return endTime;
  }

  @override
  Widget build(BuildContext context) {
    //final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        ItemTime(
          title: widget.title1 ?? "",
          setTime: (value) => _setStart(value),
          timeOld: setStartTimeOld(),
        ),
        ItemTime(
          title: widget.title2 ?? "",
          setTime: (value) => _setEnd(value),
          timeOld: setEndTimeOld(),
        ),
        if (!widget.leave)
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: SpacingUnit.x2,
                  ),
                  child: Text(
                    widget.title3 ?? "",
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                ),
                ContainerBorder(
                  width: width,
                  borderColors: colors.text.withOpacity(0.3),
                  marginTop: SpacingUnit.x2,
                  padding: SpacingUnit.x4,
                  child: Text(
                    setIntervalOnLeave().toStringAsFixed(2),
                    style: TextStyle(
                      color: colors.text.withOpacity(0.6),
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                )
              ],
            ),
          ),
        if (widget.error != '')
          Padding(
            padding: const EdgeInsets.only(
                top: SpacingUnit.x0_25, bottom: SpacingUnit.x3),
            child: Text(
              widget.error ?? "",
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  _setStart(DateTime value) {
    setState(() {
      widget.startTime?.call(value);
      startTime = value;
      widget.total?.call(widget.dayOrHours
          ? endTime.difference(startTime).inHours.toDouble() / 24
          : endTime.difference(startTime).inHours.toDouble());
      if (widget.leave) {
        dI<WorkAndSalaryBloc>().add(
          GetTotalWorkdayEvent(
            startTime: startTime.toString(),
            endTime: endTime.toString(),
          ),
        );
      }
    });
  }

  _setEnd(DateTime value) {
    setState(() {
      widget.endTime?.call(value);
      endTime = value;
      widget.total?.call(widget.dayOrHours
          ? endTime.difference(startTime).inHours.toDouble() / 24
          : endTime.difference(startTime).inHours.toDouble());
      if (widget.leave) {
        dI<WorkAndSalaryBloc>().add(
          GetTotalWorkdayEvent(
            startTime: startTime.toString(),
            endTime: endTime.toString(),
          ),
        );
      }
    });
  }

  double setIntervalOnLeave() {
    return widget.dayOrHours
        ? endTime.difference(startTime).inHours.toDouble() / 24
        : endTime.difference(startTime).inHours.toDouble();
  }
}
