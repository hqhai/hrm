import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_event.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ActivateWidget extends StatefulWidget {
  const ActivateWidget({super.key});

  @override
  State<ActivateWidget> createState() => _ActivateWidgetState();
}

class _ActivateWidgetState extends State<ActivateWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerScreenMain(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: listActivate
              .mapIndexed(
                (index, element) => ItemActivateWidget(
                  title: titlesActivate(index, context),
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
        _nextRequisitionListScreen(context);
      case 1:
        _nextCreateRequisitionScreen(context);
      case 2:
        _nextLeaveScreen(context);
      case 3:
        _nextTimekeepingGPSScreen(context);
    }
  }

  startTime(DateTime value) {}

  endTime(DateTime value) {}

  _nextLeaveScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.leavePage);
  }

  _nextRequisitionListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.seeRequestListPage);
  }

   _nextCreateRequisitionScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestPage);
  }
  /*_nextCreateRequisitionScreen(BuildContext context) {
    final exTra = const InformationRequestExtra(flowId: 'dhfgdhf', requestId: '').toJson();
    exTra.addAll({'type': RequisitionTypeEnum.leaveHalfDayToOneDay,});
    dI<AppNavigation>().pushName(context,
        page: Pages.createRequestLeavePage,
        extra: exTra);
  }*/

  _nextTimekeepingGPSScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool?>();
    dI<ScheduleSchoolBloc>().add(GetScheduleSchoolEvent(
      dateTime: DateTime.now(),
      completer: completer,
    ));
    final completerCheck = await completer.future;
    if(completerCheck == true){
      if(!currentContext.mounted) return;
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.timekeepingGPSPage,
      );
    }
    else if(completerCheck == null){
      if(!currentContext.mounted) return;
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
