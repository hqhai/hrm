import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_overtime_history.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemOverTimeHistory extends StatelessWidget {
  const ItemOverTimeHistory({super.key, required this.userOverTimeHistory});

  final UserOverTimeHistoryModel userOverTimeHistory;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
        borderColors: colors.outline.withOpacity(0.3),
        child: Column(
          children: [
            TitleValueLeave(
              font: FontWeight.w600,
              title: appLocalizations.oTSalary,
              value: userOverTimeHistory.overTimeSalaryMultiplier.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              font: FontWeight.w600,
              title: appLocalizations.oTMakeUpLeave,
              value: userOverTimeHistory.overTimeLeaveMultiplier.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              font: FontWeight.w600,
              title: appLocalizations.oTCoefficient,
              value: userOverTimeHistory.overTimeRate.toString(),
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              font: FontWeight.w600,
              title: appLocalizations.dateType,
              value: userOverTimeHistory.overTimeDay?.configEnumOvertimeDayName ?? "",
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
            TitleValueLeave(
              font: FontWeight.w600,
              title: appLocalizations.timeFrame,
              value:
                  '${strSeconds(userOverTimeHistory.startTime) ?? ""} - ${strSeconds(userOverTimeHistory.endTime) ?? ""}',
              size: SpacingUnit.x4,
              padding: SpacingUnit.x3,
            ),
          ],
        ));
  }
}
