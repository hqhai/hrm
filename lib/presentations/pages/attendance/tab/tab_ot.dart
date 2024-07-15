import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTTab extends StatelessWidget {
  const OTTab({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(state.attendance.userWorkingHistories);
        return Column(
          children: [
            TitleValueLeave(
              title: appLocalizations.totalOTHours,
              value: userWorkingHistoryModel.workTimeActual.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.oTCoefficient,
              value: userWorkingHistoryModel.workTimeReal.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              title: appLocalizations.dateType,
              value: userWorkingHistoryModel.overTimeDay?.configEnumOvertimeDayName ?? "",
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
          ],
        );
      },
    );
  }
}
