import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemCreateIntervalOnLeave extends StatefulWidget {
  const ItemCreateIntervalOnLeave(
      {super.key,
      this.endTimeOld,
      this.startTimeOld,
      this.error,
      this.total,
      this.startTime,
      this.endTime,
      this.title,
      this.leave = false,
      required this.dayOrHours});

  final DateTime? startTimeOld, endTimeOld;
  final ValueChanged<DateTime>? startTime, endTime;
  final ValueChanged<int>? total;
  final String? title, error;
  final bool dayOrHours, leave;

  @override
  State<ItemCreateIntervalOnLeave> createState() => _ItemCreateIntervalOnLeaveState();
}

class _ItemCreateIntervalOnLeaveState extends State<ItemCreateIntervalOnLeave> {
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
    final appLocalizations = AppLocalizations.of(context)!;
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
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizations.startTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TimePicker(
                onChange: (value) => _setStart(value),
                timeSlot: setStartTimeOld(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                appLocalizations.endTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TimePicker(
                onChange: (value) => _setEnd(value),
                timeSlot: setEndTimeOld(),
              ),
            ),
          ],
        ),
        if (!widget.leave)
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x3),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: SpacingUnit.x2,
                  ),
                  child: Text(
                    appLocalizations.totalTime,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                ),
                ContainerBorder(
                  width: width * 0.25,
                  margin: SpacingUnit.x2,
                  padding: SpacingUnit.x1,
                  child: Center(
                    child: Text(
                      setIntervalOnLeave().toString(),
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        if (widget.leave)
          BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: SpacingUnit.x3),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: SpacingUnit.x2,
                      ),
                      child: Text(
                        appLocalizations.workDay,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                    ),
                    ContainerBorder(
                      width: width * 0.25,
                      margin: SpacingUnit.x2,
                      padding: SpacingUnit.x1,
                      child: Center(
                        child: Text(
                          state.totalWorkday.toString(),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x4,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        if (widget.error != '')
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x0_25, bottom: SpacingUnit.x3),
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
          ? endTime.difference(startTime).inDays
          : endTime.difference(startTime).inHours);
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
          ? endTime.difference(startTime).inDays
          : endTime.difference(startTime).inHours);
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

  int setIntervalOnLeave() {
    return widget.dayOrHours
        ? endTime.difference(startTime).inDays
        : endTime.difference(startTime).inHours;
  }
}
