import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_event.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemCalender extends StatelessWidget {
  final bool isNowDate;
  final DateTime date;
  final int month;
  final int displayType;

  const ItemCalender({
    super.key,
    required this.date,
    required this.isNowDate,
    required this.month,
    required this.displayType,
  });

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    final int index = list.indexWhere((element) => element.date?.isAtSameMomentAs(date) ?? false);
    if (index != -1) {
      return list[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel = userWorkingHistoryModelByDate(
          state.attendance.userWorkingHistories,
        );
        return InkWell(
          onTap: () => _nextItemAttendanceHistoryPage(
            userWorkingHistoryModel: userWorkingHistoryModel,
            context: context,
          ),
          child: ContainerBorder(
            marginTop: 0,
            paddingVertical: 0,
            paddingHorizontal: 0,
            circular: 0,
            widthBorder: 0.5,
            borderColors: colors.outlineVariant.withOpacity(0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x1),
                    margin: const EdgeInsets.only(top: SpacingUnit.x1, bottom: SpacingUnit.x3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x10),
                      color: isNowDate ? colors.primary : Colors.transparent,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: _colorText(context),
                        fontSize: SpacingUnit.x3_5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: value(context, userWorkingHistoryModel),
                ),
                Expanded(
                  child: check(userWorkingHistoryModel)
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: userWorkingHistoryModel!.status
                                .mapIndexed(
                                  (index, element) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                                      color: _color(context, index, userWorkingHistoryModel.status),
                                    ),
                                    margin: const EdgeInsetsDirectional.symmetric(
                                        horizontal: SpacingUnit.x0_5, vertical: SpacingUnit.x2),
                                    width: SpacingUnit.x1_5,
                                    height: SpacingUnit.x1_5,
                                  ),
                                )
                                .toList(),
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool check(UserWorkingHistoryModel? userWorkingHistoryModel) {
    return userWorkingHistoryModel != null && userWorkingHistoryModel.status.isNotEmpty;
  }

  Color _colorText(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return month != date.month
        ? colors.neutralVariant40
        : (isNowDate ? colors.background : colors.text);
  }

  Color _color(BuildContext context, int index, List<UserWorkingHistoryStatus> list) {
    final colors = AppTheme.getColors(context);
    switch (list[index]) {
      case UserWorkingHistoryStatus.onTime:
        return colors.success;
      case UserWorkingHistoryStatus.late:
        return colors.tertiary;
      case UserWorkingHistoryStatus.early:
        return colors.tertiary;
      case UserWorkingHistoryStatus.offDay:
        return colors.outline.withOpacity(0.3);
      case UserWorkingHistoryStatus.isRequest:
        return colors.primary;
      case UserWorkingHistoryStatus.forgotChecking:
        return colors.error;
      case UserWorkingHistoryStatus.offWork:
        return colors.outline.withOpacity(0.3);
      case UserWorkingHistoryStatus.holiday:
        return colors.sunriseYellow;
      case UserWorkingHistoryStatus.noAttendance:
        return colors.cyan;
      case UserWorkingHistoryStatus.offSet:
        return colors.goldenPurple;
      case UserWorkingHistoryStatus.invalid:
        return colors.error;
    }
  }

  _nextItemAttendanceHistoryPage({
    required BuildContext context,
    UserWorkingHistoryModel? userWorkingHistoryModel,
  }) async {
    if (userWorkingHistoryModel != null) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      final Completer completerRequest = Completer<bool>();
      final Completer completerAttendances = Completer<bool>();
      final Completer completerShift = Completer<bool>();
      dialogIndicator(
        context: context,
      );
      dI<ShiftBloc>().add(GetShiftByIdEvent(
        id: userWorkingHistoryModel.workShiftId,
        completer: completerShift,
      ));
      dI<RequestWorkSheetBloc>().add(GetRequestsByIdsEvent(
        ids: userWorkingHistoryModel.requestIds,
        completer: completerRequest,
      ));
      dI<WorkSheetBloc>().add(GetAttendancesByDateEvent(
        date: userWorkingHistoryModel.date ?? date,
        completer: completerAttendances,
      ));
      final checkRequest = await completerRequest.future;
      final checkAttendances = await completerAttendances.future;
      final checkShift = await completerShift.future;
      if (checkRequest && checkAttendances && checkShift) {
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pop(context);
        dI<AppNavigation>().pushName(currentContext, page: Pages.historyAttendancePage, extra: {
          'dateTime': userWorkingHistoryModel.date ?? date,
        });
      }
    }
  }

  Widget value(BuildContext context, UserWorkingHistoryModel? userWorkingHistoryModel) {
    final colors = AppTheme.getColors(context);
    switch (displayType) {
      case 2:
        return Column(
          children: [
            Text(
              strSeconds(userWorkingHistoryModel?.checkIn) ?? '',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x2_5,
              ),
            ),
            Text(
              userWorkingHistoryModel?.checkIn != null ? '-' : '',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
            Text(
              strSeconds(userWorkingHistoryModel?.checkOut) ?? '',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x2_5,
              ),
            ),
          ],
        );
      case 1:
        return Text(
          Duration(seconds: userWorkingHistoryModel?.workTimeActual.toInt() ?? 0)
              .inHours
              .toString(),
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x2_5,
          ),
        );
      case 3:
        return Text(
          (userWorkingHistoryModel?.salaryRate ?? 0).toString(),
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x2_5,
          ),
        );
      default:
        return Container();
    }
  }
}
