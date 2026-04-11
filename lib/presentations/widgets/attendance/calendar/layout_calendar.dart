import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/common/utils/attendance_navigation.dart';
import 'package:base_app/presentations/pages/attendance/item_day_calendar_attendance_history.dart';
import 'package:base_app/presentations/pages/attendance/layout_calendar_attendance_history.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/popup_menu_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final layoutCalendarPageRoute = GoRoute(
  path: Pages.layoutCalendarPage,
  builder: (context, GoRouterState state) {
    final query = state.uri.queryParameters;
    return LayoutCalendar(
      currentDateTime: query['currentDateTime'] == null
          ? DateTime.now()
          : DateTime.parse(query['currentDateTime']!),
    );
  },
);

const _kPageRange = 120;

class LayoutCalendar extends StatefulWidget {
  final DateTime? currentDateTime;

  const LayoutCalendar({
    super.key,
    this.currentDateTime,
  });

  @override
  State<LayoutCalendar> createState() => _LayoutCalendarState();
}

class _LayoutCalendarState extends State<LayoutCalendar> {
  late final DateTime _baseMonth;
  late final PageController _pageController;
  int _currentPage = _kPageRange;
  int displayType = 2;

  final _cache = <String, Attendance>{};
  final _loading = <String>{};
  late DateTime _selectedDate;
  String? _pendingKey;
  late final StreamSubscription<AttendanceState> _blocSub;

  @override
  void initState() {
    super.initState();
    final init = widget.currentDateTime ?? DateTime.now();
    _baseMonth = DateTime(init.year, init.month, 1);
    _selectedDate = DateTime(init.year, init.month, init.day);
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
    final startTime = getFirstDayOfMonth(month);
    final endTime = getLastDayOfMonth(month);
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
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
    final key = _keyFor(DateTime(_selectedDate.year, _selectedDate.month, 1));
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

  Future<void> _navigateToDetail(BuildContext context) async {
    final working = _selectedWorking();
    if (working == null) return;
    await navigateToAttendanceDetail(
      context: context,
      working: working,
      fallbackDate: _selectedDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
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
        actions: [
          InkWell(
            onTap: () {
              // Force refresh current month.
              final key = _keyFor(_monthAt(_currentPage));
              _cache.remove(key);
              _fetchMonth(_monthAt(_currentPage));
            },
            child: SvgPicture.asset(
              height: SpacingUnit.x12_5,
              width: SpacingUnit.x12_5,
              Assets.images.icon.home.worksheet.worksheet2,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
          ),
          PopupMenuCalender(
            index: displayType,
            onChangeCheckOpacity: (_) {},
            displayType: (value) {
              setState(() => displayType = value);
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
                  onTap: _goToToday,
                  child: Padding(
                    padding: const EdgeInsets.only(right: SpacingUnit.x2),
                    child: Text(
                      l10n.today,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFf38120),
                        fontWeight: FontWeight.w600,
                      ),
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
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x4,
              vertical: SpacingUnit.x2,
            ),
            child: Row(
              children: [
                l10n.mon, l10n.tue, l10n.wed,
                l10n.thu, l10n.fri, l10n.sat, l10n.sun,
              ].map((label) {
                return Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.text.withValues(alpha: 0.4),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(height: 1, color: colors.text.withValues(alpha: 0.08)),
          // Calendar grid only (swipe up/down)
          Expanded(
            child: BlocListener<AttendanceBloc, AttendanceState>(
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
                    child: (loading && att == null)
                        ? const Center(
                            child: AppLoadingIndicator(),
                          )
                        : MonthGridAttendanceHistory(
                            month: month.month,
                            year: month.year,
                            workingHistories: histories,
                            selectedDate: _selectedDate,
                            onDaySelected: _onDaySelected,
                          ),
                  );
                },
              ),
            ),
          ),
          // Fixed bottom detail panel
          Divider(height: 1, color: colors.text.withValues(alpha: 0.08)),
          _SelectedDayPanel(
            date: _selectedDate,
            working: _selectedWorking(),
            displayType: displayType,
            onViewDetail: () => _navigateToDetail(context),
            l10n: l10n,
            colors: colors,
            theme: theme,
          ),
        ],
      ),
    );
  }

}

class _SelectedDayPanel extends StatelessWidget {
  final DateTime date;
  final UserWorkingHistoryModel? working;
  final int displayType;
  final VoidCallback onViewDetail;
  final AppLocalizations l10n;
  final dynamic colors;
  final ThemeData theme;

  const _SelectedDayPanel({
    required this.date,
    required this.working,
    required this.displayType,
    required this.onViewDetail,
    required this.l10n,
    required this.colors,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      decoration: BoxDecoration(
        color: colors.text.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(SpacingUnit.x4),
        border: Border.all(color: colors.text.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: date + view detail button
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: working?.date != null
                        ? const Color(0xFF014282)
                        : colors.text.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(SpacingUnit.x5),
                  ),
                  child: Text(
                    l10n.detailWork,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: working?.date != null
                          ? Colors.white
                          : colors.text.withValues(alpha: 0.3),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingUnit.x3),
          // Content changes based on displayType
          if (displayType == 1) _buildTimeWork(),
          if (displayType == 2) _buildDetailWork(),
          if (displayType == 3) _buildSummary(),
        ],
      ),
    );
  }

  /// displayType 1: Số giờ làm việc
  Widget _buildTimeWork() {
    return Column(
      children: [
        Row(
          children: [
            _chip(Icons.access_time_rounded, Colors.blue, l10n.totalTimeWork,
                strTimeFromInt(working?.workTimeActual.toInt() ?? 0)),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.work_outline_rounded, Colors.purple, l10n.workInDay,
                (working?.actualRate ?? 0).toString()),
          ],
        ),
        const SizedBox(height: SpacingUnit.x3),
        Row(
          children: [
            _chip(Icons.more_time_rounded, Colors.teal, l10n.ot,
                strTimeFromInt(working?.overTime.toInt() ?? 0)),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.build_circle_outlined, Colors.indigo,
                l10n.totalTimeWorkCompensatory,
                strTimeFromInt(working?.makeUpTime ?? 0)),
          ],
        ),
      ],
    );
  }

  /// displayType 2: Chi tiết (check-in/out, đi muộn, về sớm)
  Widget _buildDetailWork() {
    final checkInStr = strSeconds(working?.checkIn);
    final checkOutStr = strSeconds(working?.checkOut);
    return Column(
      children: [
        Row(
          children: [
            _chip(Icons.login_rounded, Colors.green, l10n.checkIn,
                checkInStr ?? '--:--'),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.logout_rounded, Colors.red, l10n.checkOut,
                checkOutStr ?? '--:--'),
          ],
        ),
        const SizedBox(height: SpacingUnit.x3),
        Row(
          children: [
            _chip(Icons.access_time_rounded, Colors.blue, l10n.totalTimeWork,
                strTimeFromInt(working?.workTimeActual.toInt() ?? 0)),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.work_outline_rounded, Colors.purple, l10n.workInDay,
                (working?.actualRate ?? 0).toString()),
          ],
        ),
        const SizedBox(height: SpacingUnit.x3),
        Row(
          children: [
            _chip(Icons.schedule_rounded, Colors.orange, l10n.minutesToLate,
                strTimeSFromInt(working?.timeLate.toInt() ?? 0)),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.directions_run_rounded, Colors.red.shade300,
                l10n.minutesToEarly,
                strTimeSFromInt(working?.timeEarly.toInt() ?? 0)),
          ],
        ),
      ],
    );
  }

  /// displayType 3: Công tổng hợp (salary rate, leave, holiday, etc.)
  Widget _buildSummary() {
    return Column(
      children: [
        Row(
          children: [
            _chip(Icons.payments_outlined, Colors.green, l10n.salaryWork,
                (working?.salaryRate ?? 0).toString()),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.work_outline_rounded, Colors.blue, l10n.workInDay,
                (working?.actualRate ?? 0).toString()),
          ],
        ),
        const SizedBox(height: SpacingUnit.x3),
        Row(
          children: [
            _chip(Icons.beach_access_outlined, Colors.purple, l10n.leave,
                (working?.leaveRate ?? 0).toString()),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.festival_outlined, Colors.amber, l10n.holiday,
                (working?.holidayRate ?? 0).toString()),
          ],
        ),
        const SizedBox(height: SpacingUnit.x3),
        Row(
          children: [
            _chip(Icons.money_off_rounded, Colors.grey, l10n.noSalaryWork,
                (working?.noSalaryRate ?? 0).toString()),
            const SizedBox(width: SpacingUnit.x3),
            _chip(Icons.more_time_rounded, Colors.teal, l10n.ot,
                strTimeFromInt(working?.overTime.toInt() ?? 0)),
          ],
        ),
      ],
    );
  }

  Widget _chip(IconData icon, Color iconColor, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: SpacingUnit.x2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700, color: colors.text)),
                Text(label,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.text.withValues(alpha: 0.45),
                        fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  final int residual = days.length % 7;
  if (residual != 0) {
    days.removeRange(days.length - residual, days.length);
  }
  return days;
}
