import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_event.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/widgets/dialog/no_connection/no_connection_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
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

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(
      List<UserWorkingHistoryModel> list) {
    final int index = list
        .indexWhere((element) => element.date?.isAtSameMomentAs(date) ?? false);
    if (index != -1) {
      return list[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel = userWorkingHistoryModelByDate(
          state.attendance.userWorkingHistories,
        );
        final dotColors = _statusDotColors(userWorkingHistoryModel, colors);
        final isCurrentMonth = date.month == month;
        final isWeekend = date.weekday >= 6;

        return InkWell(
          onTap: () => _nextItemAttendanceHistoryPage(
            userWorkingHistoryModel: userWorkingHistoryModel,
            context: context,
          ),
          customBorder: const CircleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Day number circle
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isNowDate ? Colors.red : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Text(
                  date.day.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isNowDate ? FontWeight.w700 : FontWeight.w400,
                    color: isNowDate
                        ? Colors.white
                        : !isCurrentMonth
                            ? colors.text.withValues(alpha: 0.25)
                            : isWeekend
                                ? colors.text.withValues(alpha: 0.4)
                                : colors.text,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              // Status dots
              SizedBox(
                height: 6,
                child: dotColors.isEmpty
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0;
                              i < dotColors.length && i < 3;
                              i++) ...[
                            if (i > 0) const SizedBox(width: 2),
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: dotColors[i],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Color> _statusDotColors(
    UserWorkingHistoryModel? working,
    dynamic colors,
  ) {
    if (working == null) return const [];
    final hasStatus = working.status.isNotEmpty;
    if (!hasStatus && working.checkIn == null && working.checkOut == null) {
      return const [];
    }
    final result = <Color>[];

    for (final s in working.status) {
      switch (s) {
        case UserWorkingHistoryStatus.onTime:
          result.add(colors.success);
          break;
        case UserWorkingHistoryStatus.late:
        case UserWorkingHistoryStatus.early:
          result.add(colors.tertiary);
          break;
        case UserWorkingHistoryStatus.forgotChecking:
        case UserWorkingHistoryStatus.invalid:
          result.add(colors.error);
          break;
        case UserWorkingHistoryStatus.isRequest:
          result.add(colors.primary);
          break;
        case UserWorkingHistoryStatus.offDay:
        case UserWorkingHistoryStatus.offWork:
          result.add(colors.outline.withValues(alpha: 0.5));
          break;
        case UserWorkingHistoryStatus.holiday:
          result.add(colors.sunriseYellow);
          break;
        case UserWorkingHistoryStatus.noAttendance:
          result.add(colors.cyan);
          break;
        case UserWorkingHistoryStatus.offSet:
          result.add(colors.goldenPurple);
          break;
        default:
          break;
      }
    }
    // Deduplicate adjacent same colors
    final deduped = <Color>[];
    for (final c in result) {
      if (deduped.isEmpty || deduped.last != c) {
        deduped.add(c);
      }
    }
    return deduped;
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
      dI<ShiftBloc>().add(GetShiftByIdsEvent(
        ids: userWorkingHistoryModel.workShiftIds,
        completer: completerShift,
      ));
      dI<RequestWorkSheetBloc>().add(GetRequestsByIdsEvent(
        ids: userWorkingHistoryModel.requestIds,
        completer: completerRequest,
      ));
      dI<WorkSheetBloc>().add(GetAttendancesByDateEvent(
        date: userWorkingHistoryModel.date ?? date,
        userId: dI<UserBloc>().state.user.id,
        completer: completerAttendances,
      ));
      final checkRequest = await completerRequest.future;
      final checkAttendances = await completerAttendances.future;
      final checkShift = await completerShift.future;
      if (checkRequest && checkAttendances && checkShift) {
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pop(context);
        dI<AppNavigation>().pushName(currentContext,
            page: Pages.historyAttendancePage,
            extra: {
              'dateTime': userWorkingHistoryModel.date ?? date,
            });
      } else {
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pop(context);
        dialogNoConnection(context: currentContext);
      }
    }
  }
}
