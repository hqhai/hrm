import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_type.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class CalendarWorkWidget extends StatefulWidget {
  const CalendarWorkWidget({super.key});

  @override
  State<CalendarWorkWidget> createState() => _CalendarWorkWidgetState();
}

class _CalendarWorkWidgetState extends State<CalendarWorkWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    final items = [
      _MenuItem(
        icon: Icons.edit_calendar_rounded,
        iconColor: const Color(0xFFf38120),
        title: l10n.registerShift,
        subtitle: l10n.registerShift,
      ),
      _MenuItem(
        icon: Icons.calendar_view_month_rounded,
        iconColor: const Color(0xFF014282),
        title: l10n.shiftManagement,
        subtitle: l10n.shiftManagement,
      ),
      _MenuItem(
        icon: Icons.admin_panel_settings_outlined,
        iconColor: Colors.teal,
        title: l10n.proactiveCaseRegistrationManagement,
        subtitle: l10n.proactiveCaseRegistrationManagement,
      ),
      _MenuItem(
        icon: Icons.fingerprint_rounded,
        iconColor: Colors.deepPurple,
        title: l10n.timeKeeping,
        subtitle: l10n.timeKeeping,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: SpacingUnit.x3,
                  mainAxisSpacing: SpacingUnit.x3,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _MenuCard(
                    item: items[index],
                    colors: colors,
                    theme: theme,
                    onTap: () => _nextScreen(context, index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        dI<AppNavigation>().pushName(context, page: Pages.registerShiftsPage);
      case 1:
        dI<AppNavigation>().push(context,
            page: Pages.registerWorkDayAdmin,
            paramsQuerry:
                ShiftsBuyUserQueryParams(type: UserType.user).toJson());
      case 2:
        dI<AppNavigation>().push(context,
            page: Pages.registerWorkDayAdmin,
            paramsQuerry:
                ShiftsBuyUserQueryParams(type: UserType.manage).toJson());
      case 3:
        _nextTimekeepingGPSScreen(context);
    }
  }

  void _nextTimekeepingGPSScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    final Completer completer = Completer<bool?>();
    dialogIndicator(context: currentContext);
    dI<ScheduleSchoolBloc>().add(GetScheduleSchoolEvent(
      dateTime: DateTime.now(),
      completer: completer,
    ));
    final completerCheck = await completer.future;

    if (completerCheck == true) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.timekeepingGPSSchool,
      );
    } else if (completerCheck == false) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      final error = dI<ScheduleSchoolBloc>().state.errorMessage;
      String? errorConvert;
      if (error.contains('DataNotExist')) {
        errorConvert = appLocalizations.youDoNotHaveAShiftToday;
      }
      _getNote(currentContext, errorConvert);
    }
  }

  void _getNote(BuildContext context, String? error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final colors = AppTheme.getColors(context);
        return Dialog(
          backgroundColor: colors.background,
          child: TimeKeepingErrorNoShift(error: error),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Data class
// ---------------------------------------------------------------------------

class _MenuItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}

// ---------------------------------------------------------------------------
// Menu Card
// ---------------------------------------------------------------------------

class _MenuCard extends StatelessWidget {
  final _MenuItem item;
  final dynamic colors;
  final ThemeData theme;
  final VoidCallback onTap;

  const _MenuCard({
    required this.item,
    required this.colors,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        decoration: BoxDecoration(
          color: item.iconColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(SpacingUnit.x4),
          border: Border.all(
            color: item.iconColor.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(SpacingUnit.x3),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 26),
            ),
            const SizedBox(height: SpacingUnit.x3),
            Text(
              item.title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.text,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
