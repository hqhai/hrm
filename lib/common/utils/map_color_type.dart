import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

final List<int> listActivate = [0, 1, 2, 3, 4, 5, 6, 7];

List<Map<String, dynamic>> mapColorAndTitle(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;
  final colors = AppTheme.getColors(context);
  final List<Map<String, dynamic>> colorAndTitle = [
    {'color': colors.success, 'title': appLocalizations.onTime},
    {'color': colors.orange, 'title': appLocalizations.lateOrEarly},
    {'color': colors.error, 'title': appLocalizations.timekeepingError},
    {'color': colors.outline.withOpacity(0.3), 'title': appLocalizations.forgotChecking},
    {'color': colors.navy, 'title': appLocalizations.isRequest},
    {'color': colors.sunriseYellow, 'title': appLocalizations.holiday},
    {'color': colors.goldenPurple, 'title': appLocalizations.workOffset},
    {'color': colors.cyan, 'title': appLocalizations.noAttendance},

  ];
  return colorAndTitle;
}
