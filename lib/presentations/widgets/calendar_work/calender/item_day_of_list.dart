import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class ItemDayOfList extends StatefulWidget {
  final ValueChanged<WorkDayRequest> onChange;
  final bool isCheckBox;
  final bool selected;
  final VoidCallback onTap;
  const ItemDayOfList({
    super.key,
    required this.dateTime,
    this.workDayId,
    required this.isCheckBox,
    required this.onChange,
    required this.selected,
    required this.onTap,
  });

  final DateTime dateTime;
  final String? workDayId;

  @override
  State<ItemDayOfList> createState() => _ItemDayOfListState();
}

class _ItemDayOfListState extends State<ItemDayOfList> {
  double heightWidget = 0;
  bool isSelect = false;

  @override
  void initState() {
    super.initState();
  }

  DateTime date(WorkDayState state) {
    final dateType = DateTime(
        widget.dateTime.year, widget.dateTime.month, widget.dateTime.day);
    return dateType;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final workDay = state.workDays[date(state)]?.items.first;
        return InkWell(
          onTap: () {
            if (workDay != const Shift()) {
              widget.onTap.call();
            }
          },
          child: Column(
            crossAxisAlignment: workDay != null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width,
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: Text(
                    '${nameWeekDay(widget.dateTime)}, ${dayMonthYear(
                      time: widget.dateTime,
                      context: context,
                    )}',
                    style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x3_5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              workDay != null
                  ? Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: colors.background,
                      padding: const EdgeInsets.all(SpacingUnit.x4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SpacingUnit.x4),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x2),
                              color: _colorByStatus(workDay.status),
                            ),
                            height: SpacingUnit.x12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${strSeconds(workDay.startTime)} - ${strSeconds(workDay.endTime)}",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                if (widget.isCheckBox &&
                                    workDay.status ==
                                        WorkShiftRequestStatus.usable) ...[
                                  Checkbox(
                                    value: widget.selected,
                                    onChanged: (value) {
                                      widget.onChange(WorkDayRequest(
                                          workDate: widget.dateTime.toString(),
                                          workShiftSettingDetailId: workDay
                                              .workShiftSettingDetailId));
                                      setState(() {
                                        isSelect = value ?? false;
                                      });
                                    },
                                  ),
                                ] else ...[
                                  _widgetStatus(workDay.status)
                                ]
                              ],
                            ),
                          ),
                          const SizedBox(height: SpacingUnit.x2),
                          Text(
                            'Ca làm việc: ${strSeconds(workDay.endTime - workDay.startTime)}',
                            style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3_5,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: SpacingUnit.x1),
                          Text(
                            'Mã ca: ${workDay.code}',
                            style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3_5,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: SpacingUnit.x1),
                          Text(
                            'Ca làm việc: ${strSeconds(workDay.startTime)} - ${strSeconds(workDay.endTime)}',
                            style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3_5,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: SpacingUnit.x1),
                          Text(
                            'Chấm công hợp lệ: ${strSeconds(workDay.checkInStartTimeValid)} - ${strSeconds(workDay.checkInEndTimeValid)}',
                            style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3_5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: colors.background,
                      padding: const EdgeInsets.all(SpacingUnit.x7),
                      child: Center(
                        child: Text(
                          'Không có ca làm việc',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3_5,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}

_widgetStatus(WorkShiftRequestStatus status) {
  switch (status) {
    case WorkShiftRequestStatus.approve:
      // return ColorUtils.parseHex('#E2F3DA');
      return Row(children: [
        SvgPicture.asset(
          _setIcon(status: status),
        ),
        const SizedBox(width: SpacingUnit.x1),
        Text(
          status.name,
          style: const TextStyle(),
        )
      ]);
    case WorkShiftRequestStatus.cancel:
      return Row(children: [
        SvgPicture.asset(
          _setIcon(status: status),
        ),
        const SizedBox(width: SpacingUnit.x1),
        Text(
          status.name,
          style: const TextStyle(),
        )
      ]);
    case WorkShiftRequestStatus.pending:
      return Row(children: [
        SvgPicture.asset(
          _setIcon(status: status),
        ),
        const SizedBox(width: SpacingUnit.x1),
        Text(
          status.name,
          style: const TextStyle(),
        )
      ]);
    case WorkShiftRequestStatus.pendingCancel:
      return Row(children: [
        SvgPicture.asset(
          _setIcon(status: status),
        ),
        const SizedBox(width: SpacingUnit.x1),
        Text(
          status.name,
          style: const TextStyle(),
        )
      ]);
    default:
      return const SizedBox();
  }
}

_colorByStatus(WorkShiftRequestStatus status) {
  switch (status) {
    case WorkShiftRequestStatus.approve:
      return ColorUtils.parseHex('#E2F3DA');
    case WorkShiftRequestStatus.cancel:
      return ColorUtils.parseHex('#FCE6EA');
    case WorkShiftRequestStatus.pending:
      return ColorUtils.parseHex('#E7DDF5');
    case WorkShiftRequestStatus.pendingCancel:
      return ColorUtils.parseHex('#FFF3E6');
    case WorkShiftRequestStatus.reject:
      return ColorUtils.parseHex('#FCE6EA');
    case WorkShiftRequestStatus.remove:
      return ColorUtils.parseHex('#FCE6EA');
    case WorkShiftRequestStatus.unusable:
      return ColorUtils.parseHex('#E3E3E3');
    case WorkShiftRequestStatus.usable:
      return ColorUtils.parseHex('#E8EBFA');

    default:
      return Colors.transparent;
  }
}

String _setIcon({required WorkShiftRequestStatus status}) {
  switch (status) {
    case WorkShiftRequestStatus.pending:
      return Assets.images.icon.work.loading;
    case WorkShiftRequestStatus.approve:
      return Assets.images.icon.work.success;
    case WorkShiftRequestStatus.reject:
      return Assets.images.icon.work.reject;
    case WorkShiftRequestStatus.pendingCancel:
      return Assets.images.icon.work.loading;
    case WorkShiftRequestStatus.cancel:
      return Assets.images.icon.work.reject;
    case WorkShiftRequestStatus.remove:
      return Assets.images.icon.work.reject;
    case WorkShiftRequestStatus.usable:
      return Assets.images.icon.work.success;
    case WorkShiftRequestStatus.unusable:
      return Assets.images.icon.work.reject;
  }
}
