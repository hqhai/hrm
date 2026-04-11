import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
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

/// Fetches shift, request, and attendance data for [working], then navigates
/// to the attendance history detail page.
///
/// Shows a loading indicator while fetching and a "no connection" dialog on
/// failure. This is the single source of truth — used by item.dart,
/// layout_calendar.dart, and layout_calendar_attendance_history.dart.
Future<void> navigateToAttendanceDetail({
  required BuildContext context,
  required UserWorkingHistoryModel working,
  required DateTime fallbackDate,
}) async {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final completerRequest = Completer<bool>();
  final completerAttendances = Completer<bool>();
  final completerShift = Completer<bool>();

  dialogIndicator(context: context);

  dI<ShiftBloc>().add(GetShiftByIdsEvent(
    ids: working.workShiftIds,
    completer: completerShift,
  ));
  dI<RequestWorkSheetBloc>().add(GetRequestsByIdsEvent(
    ids: working.requestIds,
    completer: completerRequest,
  ));
  dI<WorkSheetBloc>().add(GetAttendancesByDateEvent(
    date: working.date ?? fallbackDate,
    userId: dI<UserBloc>().state.user.id,
    completer: completerAttendances,
  ));

  final results = await Future.wait([
    completerRequest.future,
    completerAttendances.future,
    completerShift.future,
  ]);

  if (!currentContext.mounted) return;

  if (results.every((ok) => ok)) {
    dI<AppNavigation>().pop(context);
    dI<AppNavigation>().pushName(
      currentContext,
      page: Pages.historyAttendancePage,
      extra: {'dateTime': working.date ?? fallbackDate},
    );
  } else {
    dI<AppNavigation>().pop(context);
    dialogNoConnection(context: currentContext);
  }
}
