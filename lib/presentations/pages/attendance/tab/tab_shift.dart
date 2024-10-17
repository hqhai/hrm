import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/list_in_shift_tab_widget.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ShiftTab extends StatelessWidget {
  const ShiftTab({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    final index = list.indexWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
    if(index != -1) {
      return list[index];
    }
    return const UserWorkingHistoryModel();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(state.attendance.userWorkingHistories);
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleValueLeave(
                    font: FontWeight.w600,
                    title: appLocalizations.workInDay,
                    value: userWorkingHistoryModel.actualRate.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),

                  ///Cụ Hảo kêu không cần 16/9/2024
                  /*TitleValueLeave(
                    title: appLocalizations.totalTimeWork,
                    value: userWorkingHistoryModel.workTimeActual.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),*/
                  TitleValueLeave(
                    font: FontWeight.w600,
                    title: appLocalizations.minutesToLate,
                    value: userWorkingHistoryModel.timeLate.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),
                  TitleValueLeave(
                    font: FontWeight.w600,
                    title: appLocalizations.minutesToEarly,
                    value: userWorkingHistoryModel.timeEarly.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),
                  TitleValueLeave(
                    font: FontWeight.w600,
                    title: appLocalizations.totalOTHours,
                    value: userWorkingHistoryModel.overTime.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),
                  const ListShiftInTab(),
                  TitleValueLeave(
                    font: FontWeight.w600,
                    title: appLocalizations.totalTimeWorkCompensatory,
                    value: userWorkingHistoryModel.makeUpTime.toString(),
                    size: SpacingUnit.x4,
                    padding: SpacingUnit.x3,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () => _nextCreateScreen(context),
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: colors.primary,
                    size: SpacingUnit.x12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _nextCreateScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    dI<FlowBloc>().add(
      GetFlowsEvent(
        completer: completer,
        page: 1,
      ),
    );
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(currentContext, page: Pages.createRequestPage);
    }
  }
}
