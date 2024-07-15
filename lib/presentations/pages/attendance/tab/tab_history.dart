import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/item_shift_on_tab.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class OTHistory extends StatelessWidget {
  const OTHistory({super.key, required this.dateTime});

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
            ContainerBorder(
              borderColors: colors.outline,
              padding: SpacingUnit.x2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemShiftOnTab(
                    color: colors.navy,
                    title: appLocalizations.checkIn,
                    icon: Icons.login,
                    value: strSeconds(userWorkingHistoryModel.checkIn ?? 0),
                  ),
                  Container(
                    height: SpacingUnit.x11,
                    padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x10),
                    child: VerticalDivider(
                      color: colors.text,
                      width: SpacingUnit.x2,
                    ),
                  ),
                  ItemShiftOnTab(
                    title: appLocalizations.checkOut,
                    icon: Icons.logout,
                    value: strSeconds(userWorkingHistoryModel.checkOut ?? 0),
                    color: colors.tertiary,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
