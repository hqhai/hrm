import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/attendance_navigation.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
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
    for (final element in list) {
      final d = element.date;
      if (d == null) continue;
      if (d.year == date.year && d.month == date.month && d.day == date.day) {
        return element;
      }
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
                  color: isNowDate ? const Color(0xFFf38120) : Colors.transparent,
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
    if (userWorkingHistoryModel == null) return;
    await navigateToAttendanceDetail(
      context: context,
      working: userWorkingHistoryModel,
      fallbackDate: date,
    );
  }
}
