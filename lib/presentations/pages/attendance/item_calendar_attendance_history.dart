import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

/// A single cell in the monthly attendance calendar (iOS Calendar style).
class ItemCalendarAttendanceHistory extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final bool isCurrentMonth;
  final bool isWeekend;
  final bool isSelected;
  final UserWorkingHistoryModel? working;
  final ValueChanged<DateTime>? onTap;

  const ItemCalendarAttendanceHistory({
    super.key,
    required this.date,
    required this.isToday,
    required this.isCurrentMonth,
    required this.isWeekend,
    this.isSelected = false,
    this.working,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final dotColors = _statusDotColors(working);

    return InkWell(
      onTap: isCurrentMonth ? () => onTap?.call(date) : null,
      customBorder: const CircleBorder(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day number in circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isToday
                  ? const Color(0xFFf38120)
                  : isSelected
                      ? colors.text.withValues(alpha: 0.1)
                      : Colors.transparent,
              border: isSelected && !isToday
                  ? Border.all(color: colors.text.withValues(alpha: 0.3), width: 1.5)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              date.day.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: (isToday || isSelected)
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: _textColor(colors),
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
                      for (int i = 0; i < dotColors.length && i < 3; i++) ...[
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
  }

  Color _textColor(dynamic colors) {
    if (isToday) return Colors.white;
    if (!isCurrentMonth) return colors.text.withValues(alpha: 0.25);
    if (isWeekend) return colors.text.withValues(alpha: 0.4);
    return colors.text;
  }

  List<Color> _statusDotColors(UserWorkingHistoryModel? working) {
    if (working == null || working.date == null) return const [];
    final result = <Color>[];

    if (working.status.contains(UserWorkingHistoryStatus.late) ||
        working.status.contains(UserWorkingHistoryStatus.early)) {
      result.add(Colors.orange);
    }
    if (working.status.contains(UserWorkingHistoryStatus.forgotChecking)) {
      result.add(Colors.red);
    }
    if (working.status.contains(UserWorkingHistoryStatus.isRequest) ||
        working.requestIds.isNotEmpty) {
      result.add(Colors.purple);
    }
    if (working.overTime > 0) {
      result.add(Colors.teal);
    }
    if (working.status.contains(UserWorkingHistoryStatus.holiday) ||
        working.status.contains(UserWorkingHistoryStatus.offDay)) {
      result.add(Colors.grey);
    }
    if (result.isEmpty &&
        (working.checkIn != null || working.checkOut != null)) {
      result.add(Colors.green);
    }
    return result;
  }
}
