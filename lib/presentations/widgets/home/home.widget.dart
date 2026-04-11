import 'dart:async';
import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/pages/attendance/layout_calendar_attendance_history.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  DateTime currentDateTime = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  /// Local cache — prevents flicker when returning from detail screens
  /// that overwrite the shared AttendanceBloc state.
  Attendance _cachedAtt = const Attendance();
  late final StreamSubscription<AttendanceState> _blocSub;
  bool _waitingForMyMonth = false;

  @override
  void initState() {
    super.initState();
    startTime = getFirstDayOfMonth(currentDateTime);
    endTime = getLastDayOfMonth(currentDateTime);

    // Listen to bloc and only accept data meant for this screen's month.
    _blocSub = dI<AttendanceBloc>().stream.listen((state) {
      if (state.status == AttendanceStatus.getAttendanceSuccess) {
        if (_waitingForMyMonth) {
          // This is the response to OUR fetch — accept it.
          _waitingForMyMonth = false;
          if (mounted) setState(() => _cachedAtt = state.attendance);
        } else if (!_isNavigating) {
          // Normal update (month change etc.) — accept it.
          if (mounted) setState(() => _cachedAtt = state.attendance);
        }
        // If _isNavigating and not _waitingForMyMonth → ignore (stale data
        // from detail/calendar screens).
      }
    });

    _fetchCurrentMonth();
    dI<RequisitionApproveBloc>().add(const GetRequisitionApproveCountEvent());
  }

  @override
  void dispose() {
    _blocSub.cancel();
    super.dispose();
  }

  bool _isNavigating = false;

  void _fetchCurrentMonth() {
    _waitingForMyMonth = true;
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
  }

  void _upMonth() {
    setState(() {
      if (currentDateTime.month == 12) {
        currentDateTime = DateTime(currentDateTime.year + 1, 1, 1);
      } else {
        currentDateTime =
            DateTime(currentDateTime.year, currentDateTime.month + 1, 1);
      }
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    _fetchCurrentMonth();
  }

  void _downMonth() {
    setState(() {
      if (currentDateTime.month == 1) {
        currentDateTime = DateTime(currentDateTime.year - 1, 12, 1);
      } else {
        currentDateTime =
            DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
      }
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    _fetchCurrentMonth();
  }

  void _nextWorkSheet(BuildContext context) async {
    _isNavigating = true;
    await dI<AppNavigation>().push(
      context,
      page: Pages.layoutCalendarPage,
      paramsQuerry: jsonDecode(
        jsonEncode({'currentDateTime': currentDateTime.toString()}),
      ),
    );
    // Re-fetch current month data. _waitingForMyMonth ensures we only
    // accept OUR response, ignoring any stale bloc state from the detail screen.
    _isNavigating = false;
    _fetchCurrentMonth();
  }

  void _pickMonth(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    int selectedYear = currentDateTime.year;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Year selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () =>
                              setDialogState(() => selectedYear--),
                          icon: Icon(Icons.chevron_left_rounded,
                              color: colors.text),
                        ),
                        Text(
                          '$selectedYear',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF014282),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              setDialogState(() => selectedYear++),
                          icon: Icon(Icons.chevron_right_rounded,
                              color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    // Month grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2.2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: 12,
                      itemBuilder: (_, i) {
                        final m = i + 1;
                        final isSelected =
                            m == currentDateTime.month &&
                            selectedYear == currentDateTime.year;
                        final now = DateTime.now();
                        final isCurrent =
                            m == now.month && selectedYear == now.year;

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(ctx);
                            _goToMonth(DateTime(selectedYear, m, 1));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF014282)
                                  : isCurrent
                                      ? const Color(0xFFf38120)
                                          .withValues(alpha: 0.1)
                                      : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x2),
                              border: isCurrent && !isSelected
                                  ? Border.all(
                                      color: const Color(0xFFf38120),
                                      width: 1)
                                  : null,
                            ),
                            child: Text(
                              localizedMonth(l10n, m),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : colors.text,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _goToMonth(DateTime month) {
    setState(() {
      currentDateTime = month;
      startTime = getFirstDayOfMonth(currentDateTime);
      endTime = getLastDayOfMonth(currentDateTime);
    });
    _fetchCurrentMonth();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final monthName = localizedMonth(l10n, currentDateTime.month);
    final att = _cachedAtt;

    return Builder(
      builder: (context) {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SpacingUnit.x3),
                  // Month header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$monthName ${currentDateTime.year}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF014282),
                            fontSize: 22,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _pickMonth(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF014282)
                                .withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(SpacingUnit.x2),
                          ),
                          child: const Icon(Icons.calendar_month_rounded,
                              color: Color(0xFF014282), size: 24),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _downMonth,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFf38120)
                                .withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(SpacingUnit.x2),
                          ),
                          child: const Icon(Icons.chevron_left_rounded,
                              color: Color(0xFFf38120), size: 24),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _upMonth,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFf38120)
                                .withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(SpacingUnit.x2),
                          ),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: Color(0xFFf38120), size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x5),

                  // ── Hero card: Actual vs Standard ──
                  _HeroCard(
                    actual: att.actualRate,
                    standard: att.realRate,
                    salary: att.salaryRate,
                    l10n: l10n,
                    colors: colors,
                    theme: theme,
                    onTapDetails: () => _nextWorkSheet(context),
                  ),
                  const SizedBox(height: SpacingUnit.x4),

                  // ── Work time stats ──
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.access_time_rounded,
                        iconColor: Colors.blue,
                        label: l10n.workTime,
                        value: strTimeFromInt(att.workTimeActual),
                      ),
                      const SizedBox(width: SpacingUnit.x3),
                      _StatCard(
                        icon: Icons.more_time_rounded,
                        iconColor: Colors.teal,
                        label: l10n.oTSalaryH,
                        value: strTimeFromInt(att.overTimeSalary),
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.update_rounded,
                        iconColor: Colors.indigo,
                        label: l10n.oTMakeUpLeaveH,
                        value: strTimeFromInt(att.overTimeLeave),
                      ),
                      const SizedBox(width: SpacingUnit.x3),
                      _StatCard(
                        icon: Icons.beach_access_outlined,
                        iconColor: Colors.purple,
                        label: l10n.leaveWork,
                        value: att.leaveRate.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x4),

                  // ── Attendance section ──
                  Text(
                    l10n.timeKeeping,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  // Late / Early row
                  Row(
                    children: [
                      _AlertCard(
                        icon: Icons.schedule_rounded,
                        iconColor: Colors.orange,
                        label: l10n.numberOfEarly,
                        value: att.countLate.toString(),
                        subtitle:
                            '${Duration(seconds: att.timeLate).inMinutes} ${l10n.minutesToLate}',
                      ),
                      const SizedBox(width: SpacingUnit.x3),
                      _AlertCard(
                        icon: Icons.directions_run_rounded,
                        iconColor: Colors.red,
                        label: l10n.numberOfLate,
                        value: att.countEarly.toString(),
                        subtitle:
                            '${Duration(seconds: att.timeEarly).inMinutes} ${l10n.minutesToEarly}',
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x4),

                  // ── Leave section ──
                  Text(
                    l10n.leave,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.event_busy_outlined,
                        iconColor: Colors.amber.shade700,
                        label: l10n.holidayWork,
                        value: att.holidayRate.toString(),
                      ),
                      const SizedBox(width: SpacingUnit.x3),
                      _StatCard(
                        icon: Icons.swap_horiz_rounded,
                        iconColor: Colors.cyan,
                        label: l10n.i18nCompensatoryLeave,
                        value: att.compensatoryLeaveRate.toString(),
                      ),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.money_off_rounded,
                        iconColor: Colors.grey,
                        label: l10n.leaveWithoutPay,
                        value: att.noSalaryRate.toString(),
                      ),
                      const SizedBox(width: SpacingUnit.x3),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// ---------------------------------------------------------------------------
// Hero Card — Actual vs Standard work days with progress
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  final double actual;
  final double standard;
  final double salary;
  final AppLocalizations l10n;
  final dynamic colors;
  final ThemeData theme;
  final VoidCallback? onTapDetails;

  const _HeroCard({
    required this.actual,
    required this.standard,
    required this.salary,
    required this.l10n,
    required this.colors,
    required this.theme,
    this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final progress = standard > 0 ? (actual / standard).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFf38120),
            Color(0xFFe06b10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(SpacingUnit.x4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.actualWork,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${actual.toStringAsFixed(1)} / ${standard.toStringAsFixed(1)}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Circular progress
              SizedBox(
                width: 60,
                height: 60,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 5,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.white),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingUnit.x3),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: SpacingUnit.x3),
          // Salary + See details row
          Row(
            children: [
              Icon(Icons.payments_outlined,
                  color: Colors.white.withValues(alpha: 0.8), size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${l10n.salaryWork}: ${salary.toStringAsFixed(1)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onTapDetails != null)
                GestureDetector(
                  onTap: onTapDetails,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF014282),
                      borderRadius: BorderRadius.circular(SpacingUnit.x5),
                    ),
                    child: Text(
                      l10n.seeDetails,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat Card
// ---------------------------------------------------------------------------

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
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
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          color: colors.text.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          border: Border.all(color: colors.text.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: SpacingUnit.x2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.text.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Alert Card — with count subtitle
// ---------------------------------------------------------------------------

class _AlertCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String subtitle;

  const _AlertCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          border: Border.all(color: iconColor.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: SpacingUnit.x2),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.text.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: SpacingUnit.x2),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: iconColor,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.text.withValues(alpha: 0.45),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
