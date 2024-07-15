import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/attendance/tab/tab_history.dart';
import 'package:base_app/presentations/pages/attendance/tab/tab_ot.dart';
import 'package:base_app/presentations/pages/attendance/tab/tab_request.dart';
import 'package:base_app/presentations/pages/attendance/tab/tab_shift.dart';
import 'package:flutter/cupertino.dart';

List<String> tabBarAttendance(BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;

  final List<String> titles = [
    appLocalizations.timeWorking,
    appLocalizations.ot,
    appLocalizations.request,
    appLocalizations.history
  ];
  return titles;
}

List<Widget> tabAttendance(DateTime date) {
  final List<Widget> tabs = [
    ShiftTab(dateTime: date),
    OTTab(dateTime: date),
    RequestTab(dateTime: date),
    OTHistory(dateTime: date),
  ];
  return tabs;
}
