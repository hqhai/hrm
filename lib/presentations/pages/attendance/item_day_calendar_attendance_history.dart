import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/attendance/item_calendar_attendance_history.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

// ---------------------------------------------------------------------------
// Public re-usable widgets
// ---------------------------------------------------------------------------

/// Sticky weekday header row used at the top of the calendar.
class WeekdayHeaderRow extends StatelessWidget {
  const WeekdayHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.mon, l10n.tue, l10n.wed, l10n.thu, l10n.fri, l10n.sat, l10n.sun
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingUnit.x4,
        vertical: SpacingUnit.x2,
      ),
      child: Row(
        children: List.generate(7, (i) {
          return Expanded(
            child: Center(
              child: Text(
                labels[i],
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.text.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// A single month's calendar grid.
/// Accepts [workingHistories] directly so the parent can manage caching.
class MonthGridAttendanceHistory extends StatelessWidget {
  final int month;
  final int year;
  final List<UserWorkingHistoryModel> workingHistories;
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDaySelected;

  const MonthGridAttendanceHistory({
    super.key,
    required this.month,
    required this.year,
    this.workingHistories = const [],
    this.selectedDate,
    this.onDaySelected,
  });

  List<DateTime> _buildDays() {
    final firstOfMonth = DateTime(year, month, 1);
    final lastOfMonth = DateTime(year, month + 1, 0);
    final leading = firstOfMonth.weekday - 1;
    final start = firstOfMonth.subtract(Duration(days: leading));
    final totalCells = ((leading + lastOfMonth.day) / 7).ceil() * 7;
    return List<DateTime>.generate(
      totalCells,
      (i) => start.add(Duration(days: i)),
    );
  }

  UserWorkingHistoryModel? _findFor(DateTime date) {
    for (final w in workingHistories) {
      final d = w.date;
      if (d == null) continue;
      if (d.year == date.year && d.month == date.month && d.day == date.day) {
        return w;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = _buildDays();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        final date = days[index];
        final isCurrentMonth = date.month == month;
        final isToday = date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;
        final isWeekend = date.weekday >= 6;
        final isSelected = selectedDate != null &&
            date.year == selectedDate!.year &&
            date.month == selectedDate!.month &&
            date.day == selectedDate!.day;

        return ItemCalendarAttendanceHistory(
          date: date,
          isToday: isToday,
          isCurrentMonth: isCurrentMonth,
          isWeekend: isWeekend,
          isSelected: isSelected,
          working: isCurrentMonth ? _findFor(date) : null,
          onTap: onDaySelected,
        );
      },
    );
  }
}

/// Legend explaining the status dot colors.
class AttendanceLegend extends StatelessWidget {
  const AttendanceLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final entries = <(Color, String)>[
      (Colors.green, l10n.onTime),
      (Colors.orange, l10n.timeLate),
      (Colors.red, l10n.forgotChecking),
      (Colors.purple, l10n.isRequest),
      (Colors.teal, l10n.ot),
      (Colors.grey, l10n.holiday),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
      child: Wrap(
        spacing: SpacingUnit.x4,
        runSpacing: SpacingUnit.x2,
        children: [
          for (final e in entries)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: e.$1,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: SpacingUnit.x1),
                Text(
                  e.$2,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.text.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// Legacy widget kept for backward compatibility.
class BodyCalendarAttendanceHistory extends StatelessWidget {
  final int month;
  final int year;

  const BodyCalendarAttendanceHistory({
    super.key,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WeekdayHeaderRow(),
        const SizedBox(height: SpacingUnit.x1),
        MonthGridAttendanceHistory(month: month, year: year),
        const SizedBox(height: SpacingUnit.x3),
        const AttendanceLegend(),
        const SizedBox(height: SpacingUnit.x3),
      ],
    );
  }
}
