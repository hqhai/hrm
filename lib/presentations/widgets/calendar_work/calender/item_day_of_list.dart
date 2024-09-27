import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
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
  final List<WorkDayRequest> listSelect;
  const ItemDayOfList({
    super.key,
    required this.dateTime,
    this.workDayId,
    required this.isCheckBox,
    required this.onChange,
    required this.selected,
    required this.onTap,
    required this.listSelect,
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
        final workDay = state.workDays[date(state)]?.items ?? [];
        return Column(
          crossAxisAlignment: workDay.isNotEmpty
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
            workDay.isNotEmpty
                ? Container(
                    width: MediaQuery.sizeOf(context).width,
                    color: colors.background,
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...workDay.map((e) {
                          bool check = widget.listSelect
                              .where((element) =>
                                  element.workShiftSettingDetailId ==
                                  e.workShiftSettingDetailId)
                              .isNotEmpty;

                          return InkWell(
                            onTap: () {
                              if (workDay.isNotEmpty) {
                                dI<AppNavigation>().push(context,
                                    page: Pages.shiftsPage,
                                    paramsQuerry: ShiftsQueryParams(
                                            date: widget.dateTime,
                                            id: e.workShiftSettingDetailId)
                                        .toJson());
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpacingUnit.x4,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: SpacingUnit.x1),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x2),
                                color: _colorByStatus(e.status),
                              ),
                              height: SpacingUnit.x12,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${strSeconds(e.startTime)} - ${strSeconds(e.endTime)}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  if (widget.isCheckBox &&
                                      (e.status ==
                                          WorkShiftRequestStatus.usable || e.status ==
                                      WorkShiftRequestStatus.reject|| e.status ==
                                          WorkShiftRequestStatus.cancel)) ...[
                                    Checkbox(
                                      side: const BorderSide(
                                          color: Color(0xff585858)),
                                      value: check,
                                      onChanged: (value) {
                                        widget.onChange(
                                          WorkDayRequest(
                                              workDate:
                                                  widget.dateTime.toString(),
                                              workShiftSettingDetailId:
                                                  e.workShiftSettingDetailId),
                                        );
                                      },
                                    ),
                                  ] else ...[
                                    _widgetStatus(e.status)
                                  ]
                                ],
                              ),
                            ),
                          );
                        }),
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
        );
      },
    );
  }
}

_widgetStatus(WorkShiftRequestStatus status) {
  return Row(children: [
    SvgPicture.asset(
      _setIcon(status: status),
    ),
    const SizedBox(width: SpacingUnit.x1),
    Text(
      status.configWorkShiftRequestStatusName,
      style: const TextStyle(),
    )
  ]);
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
      return ColorUtils.parseHex('#E8EBFA');
    case WorkShiftRequestStatus.remove:
      return ColorUtils.parseHex('#F1F6FF');
    case WorkShiftRequestStatus.unusable:
      return ColorUtils.parseHex('#E3E3E3');
    case WorkShiftRequestStatus.usable:
      return ColorUtils.parseHex('#2F6BFF').withOpacity(0.3);

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
    default:
      return '';
  }
}
