import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ShiftTab extends StatelessWidget {
  const ShiftTab({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(state.attendance.userWorkingHistories);
        return Column(
          children: [
            TitleValueLeave(
              title: appLocalizations.workInDay,
              value: userWorkingHistoryModel.workTimeReal.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.minutesToLate,
              value: userWorkingHistoryModel.timeLate.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.minutesToEarly,
              value: userWorkingHistoryModel.timeEarly.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.totalOTHours,
              value: userWorkingHistoryModel.overTime.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.totalTimeWorkCompensatory,
              value: '0',
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingUnit.x3,
              ),
              child: Divider(
                height: SpacingUnit.x0_25,
                color: colors.surfaceVariantHigh,
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.typeOfShift,
              value: userWorkingHistoryModel.overTimeDay?.configEnumOvertimeDayName ?? "",
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
              font: FontWeight.w700,
            ),
          ],
        );
      },
    );
  }
}
