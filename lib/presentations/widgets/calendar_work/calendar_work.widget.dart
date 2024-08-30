import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_type.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:collection/collection.dart';
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
    final colors = AppTheme.getColors(context);
    return Container(
      color: colors.text.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: ItemUtils.listCalendarWork
              .mapIndexed(
                (index, element) => ItemActivateWidget(
                  title: ItemUtils.titlesCalendarWork(index, context),
                  callback: () => _nextScreen(context, index),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  _nextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        dI<AppNavigation>().pushName(context, page: Pages.registerShiftsPage);
      case 1:
        dI<AppNavigation>().push(context,
            page: Pages.registerWorkDayAdmin,
            paramsQuerry: ShiftsBuyUserQueryParams(type: UserType.user).toJson());
      case 2:
        dI<AppNavigation>().push(context,
            page: Pages.registerWorkDayAdmin,
            paramsQuerry: ShiftsBuyUserQueryParams(type: UserType.manage).toJson());
      case 3:
        _nextTimekeepingGPSScreen(context);
    }
  }

  _nextTimekeepingGPSScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool?>();
    dialogIndicator(
      context: context,
    );
    dI<ScheduleSchoolBloc>().add(GetScheduleSchoolEvent(
      dateTime: DateTime.now(),
      completer: completer,
    ));
    final completerCheck = await completer.future;
    if (completerCheck == true) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(
        currentContext,
        //page: Pages.timekeepingGPSPage,
        page: Pages.timekeepingGPSSchool,
      );
    } else if (completerCheck == null) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      getNote(currentContext);
    }
  }

  getNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final appLocalizations = AppLocalizations.of(context)!;
        final colors = AppTheme.getColors(context);
        return Dialog(
          backgroundColor: colors.background,
          child: TitleDialog(
            title: appLocalizations.youDoNotHaveAShiftToday,
          ),
        );
      },
    );
  }
}
