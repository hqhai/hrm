import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/home_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/widgets/attendance/attendance/form_change_time.dart';
import 'package:base_app/presentations/widgets/attendance/attendance/item_work_sheet.dart';
import 'package:base_app/presentations/widgets/custom/app_button_next_screen.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  DateTime now = DateTime.now(),
      currentDateTime = DateTime.now(),
      startTime = DateTime.now(),
      endTime = DateTime.now();

  @override
  void initState() {
    startTime = getFirstDayOfMonth(currentDateTime);
    endTime = getLastDayOfMonth(currentDateTime);
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(startTime: startTime, endTime: endTime));
    dI<RequisitionApproveBloc>().add(const GetRequisitionApproveCountEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: ContainerScreenMain(
            padding: 0,
            margin: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormChangeTime(
                  month: currentDateTime.month.toString(),
                  year: currentDateTime.year.toString(),
                  downMonth: () => downMonth(),
                  upMonth: () => upMonth(),
                ),
                Column(
                  children: TitleHome.titleHome()
                      .mapIndexed(
                        (index, element) => ItemWorkSheet(
                          title: element,
                          value: listWork(state.attendance)[index],
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButtonNextScreen(
                    title: appLocalizations.seeDetails,
                    onSubmit: () => nextWorkSheet(context),
                    color: colors.navy.withValues(alpha: 0.15),
                    colorText: colors.primary,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> listWork(Attendance attendance) {
    List<String> list = [...attendance.toListString()];
    return list;
  }

  downMonth() {
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
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(endTime: endTime, startTime: startTime));
  }

  upMonth() {
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
    dI<AttendanceBloc>()
        .add(GetWorkSheetEvent(endTime: endTime, startTime: startTime));
  }

  nextWorkSheet(BuildContext context) {
    dI<AppNavigation>().push(
      context,
      page: Pages.layoutCalendarPage,
      paramsQuerry: jsonDecode(
        jsonEncode(
          {'currentDateTime': currentDateTime.toString()},
        ),
      ),
    );
  }
}
