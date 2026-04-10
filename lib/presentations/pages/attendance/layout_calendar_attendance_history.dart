import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/attendance/item_day_calendar_attendance_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final layoutCalendarAttendanceHistoryPageRoute = GoRoute(
  path: Pages.layoutCalendarAttendanceHistoryPage,
  name: Pages.layoutCalendarAttendanceHistoryPage,
  builder: (context, GoRouterState state) =>
      const LayoutCalendarAttendanceHistory(),
);

String localizedMonth(AppLocalizations l10n, int month) {
  switch (month) {
    case 1: return l10n.january;
    case 2: return l10n.february;
    case 3: return l10n.march;
    case 4: return l10n.april;
    case 5: return l10n.may;
    case 6: return l10n.june;
    case 7: return l10n.july;
    case 8: return l10n.august;
    case 9: return l10n.september;
    case 10: return l10n.october;
    case 11: return l10n.november;
    case 12: return l10n.december;
    default: return '';
  }
}

const _kPageRange = 120;

class LayoutCalendarAttendanceHistory extends StatefulWidget {
  const LayoutCalendarAttendanceHistory({super.key});

  @override
  State<LayoutCalendarAttendanceHistory> createState() =>
      _LayoutCalendarAttendanceHistoryState();
}

class _LayoutCalendarAttendanceHistoryState
    extends State<LayoutCalendarAttendanceHistory> {
  late final DateTime _baseMonth;
  late final PageController _pageController;
  int _currentPage = _kPageRange;

  final _cache = <String, Attendance>{};
  final _loading = <String>{};
  late DateTime _selectedDate;
  String? _pendingKey;
  late final StreamSubscription<AttendanceState> _blocSub;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _baseMonth = DateTime(now.year, now.month, 1);
    _selectedDate = DateTime(now.year, now.month, now.day);
    _pageController = PageController(initialPage: _kPageRange);

    _blocSub = dI<AttendanceBloc>().stream.listen((state) {
      if (state.status == AttendanceStatus.getAttendanceSuccess &&
          _pendingKey != null) {
        if (mounted) {
          setState(() {
            _cache[_pendingKey!] = state.attendance;
            _loading.remove(_pendingKey!);
          });
        }
      }
    });

    _fetchMonth(_baseMonth);
  }

  @override
  void dispose() {
    _blocSub.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String _keyFor(DateTime month) => '${month.year}-${month.month}';

  DateTime _monthAt(int pageIndex) {
    final delta = pageIndex - _kPageRange;
    return DateTime(_baseMonth.year, _baseMonth.month + delta, 1);
  }

  void _fetchMonth(DateTime month) {
    final key = _keyFor(month);
    if (_cache.containsKey(key)) return;
    setState(() => _loading.add(key));
    _pendingKey = key;
    dI<AttendanceBloc>().add(
      GetWorkSheetEvent(startTime: month, endTime: month),
    );
  }

  void _goToToday() {
    _pageController.animateToPage(
      _kPageRange,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    final now = DateTime.now();
    setState(() => _selectedDate = DateTime(now.year, now.month, now.day));
  }

  void _onPageChanged(int page) {
    final month = _monthAt(page);
    final now = DateTime.now();
    setState(() {
      _currentPage = page;
      // Default: today if current month, otherwise 1st of the month
      if (month.year == now.year && month.month == now.month) {
        _selectedDate = DateTime(now.year, now.month, now.day);
      } else {
        _selectedDate = DateTime(month.year, month.month, 1);
      }
    });
    _fetchMonth(month);
  }

  void _onDaySelected(DateTime date) {
    setState(() => _selectedDate = date);
  }

  UserWorkingHistoryModel? _selectedWorking() {
    final key =
        _keyFor(DateTime(_selectedDate.year, _selectedDate.month, 1));
    final att = _cache[key];
    if (att == null) return null;
    for (final w in att.userWorkingHistories) {
      final d = w.date;
      if (d == null) continue;
      if (d.year == _selectedDate.year &&
          d.month == _selectedDate.month &&
          d.day == _selectedDate.day) {
        return w;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final currentMonth = _monthAt(_currentPage);
    final monthName = localizedMonth(l10n, currentMonth.month);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          l10n.timeKeeping,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _goToToday,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              child: Center(
                child: Text(
                  l10n.today,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state.status == AttendanceStatus.getAttendanceSuccess &&
              _pendingKey != null &&
              !_cache.containsKey(_pendingKey!)) {
            setState(() {
              _cache[_pendingKey!] = state.attendance;
              _loading.remove(_pendingKey!);
            });
          }
        },
        child: Column(
          children: [
            // ── TOP: Month header + Calendar (scrollable via PageView) ──
            // Month header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingUnit.x4,
                vertical: SpacingUnit.x2,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '$monthName ${currentMonth.year}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.text,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x1),
                      child: Icon(Icons.chevron_left_rounded,
                          color: colors.text.withValues(alpha: 0.5),
                          size: SpacingUnit.x7),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x1),
                      child: Icon(Icons.chevron_right_rounded,
                          color: colors.text.withValues(alpha: 0.5),
                          size: SpacingUnit.x7),
                    ),
                  ),
                ],
              ),
            ),
            // Weekday header
            const WeekdayHeaderRow(),
            Divider(height: 1, color: colors.text.withValues(alpha: 0.08)),
            // Calendar grid only (swipe up/down to change month)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: _kPageRange * 2 + 1,
                itemBuilder: (context, index) {
                  final month = _monthAt(index);
                  final key = _keyFor(month);
                  final att = _cache[key];
                  final loading = _loading.contains(key);
                  final histories = att?.userWorkingHistories ?? [];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x4,
                      vertical: SpacingUnit.x3,
                    ),
                    child: Column(
                      children: [
                        if (loading && att == null)
                          const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.red,
                              ),
                            ),
                          )
                        else ...[
                          MonthGridAttendanceHistory(
                            month: month.month,
                            year: month.year,
                            workingHistories: histories,
                            selectedDate: _selectedDate,
                            onDaySelected: _onDaySelected,
                          ),
                          const SizedBox(height: SpacingUnit.x2),
                          const AttendanceLegend(),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── BOTTOM: Fixed detail panel ──
            Divider(height: 1, color: colors.text.withValues(alpha: 0.08)),
            _SelectedDayPanel(
              date: _selectedDate,
              working: _selectedWorking(),
              onViewDetail: () {
                dI<AppNavigation>().pushName(
                  context,
                  page: Pages.historyAttendancePage,
                  extra: {'dateTime': _selectedDate},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fixed bottom detail panel
// ---------------------------------------------------------------------------

class _SelectedDayPanel extends StatelessWidget {
  final DateTime date;
  final UserWorkingHistoryModel? working;
  final VoidCallback onViewDetail;

  const _SelectedDayPanel({
    required this.date,
    required this.working,
    required this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final checkInStr = strSeconds(working?.checkIn);
    final checkOutStr = strSeconds(working?.checkOut);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        SpacingUnit.x4,
        SpacingUnit.x3,
        SpacingUnit.x4,
        SpacingUnit.x4,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: date + detail button
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${l10n.day} ${date.day}/${date.month}/${date.year}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: working?.date != null ? onViewDetail : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.detailWork,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.chevron_right_rounded,
                          color: Colors.red, size: 18),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpacingUnit.x3),
            // Row 1: Check-in / Check-out
            Row(
              children: [
                _InfoChip(
                  icon: Icons.login_rounded,
                  iconColor: Colors.green,
                  label: l10n.checkIn,
                  value: checkInStr ?? '--:--',
                ),
                const SizedBox(width: SpacingUnit.x3),
                _InfoChip(
                  icon: Icons.logout_rounded,
                  iconColor: Colors.red,
                  label: l10n.checkOut,
                  value: checkOutStr ?? '--:--',
                ),
              ],
            ),
            const SizedBox(height: SpacingUnit.x3),
            // Row 2: Total time / Work rate / Late / Early
            Row(
              children: [
                _InfoChip(
                  icon: Icons.access_time_rounded,
                  iconColor: Colors.blue,
                  label: l10n.totalTimeWork,
                  value: strTimeFromInt(working?.workTimeActual.toInt() ?? 0),
                ),
                const SizedBox(width: SpacingUnit.x3),
                _InfoChip(
                  icon: Icons.schedule_rounded,
                  iconColor: Colors.orange,
                  label: l10n.minutesToLate,
                  value: strTimeSFromInt(working?.timeLate.toInt() ?? 0),
                ),
                const SizedBox(width: SpacingUnit.x3),
                _InfoChip(
                  icon: Icons.directions_run_rounded,
                  iconColor: Colors.red.shade300,
                  label: l10n.minutesToEarly,
                  value: strTimeSFromInt(working?.timeEarly.toInt() ?? 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: SpacingUnit.x1_5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.text,
                    fontSize: 13,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.text.withValues(alpha: 0.45),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
