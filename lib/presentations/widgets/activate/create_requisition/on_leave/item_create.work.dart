import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemTakeLeaveWork extends StatefulWidget {
  const ItemTakeLeaveWork({
    super.key,
    required this.takeLeaveType,
  });

  final EnumTakeLeaveType takeLeaveType;

  @override
  State<ItemTakeLeaveWork> createState() => _ItemTakeLeaveWorkState();
}

class _ItemTakeLeaveWorkState extends State<ItemTakeLeaveWork> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
      builder: (context, state) {
        final leaveOT = state.userLeave.userLeaveHistoryTypes
            .firstWhere((element) => element.type == TypeLeaveEnum.overTimeLeave);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.takeLeaveType == EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave ||
                widget.takeLeaveType == EnumTakeLeaveType.otherPaidLeave) ...[
              item(
                context: context,
                title: appLocalizations.leaveNumberUsed,
                value: state.userLeave.total.toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberPermission,
                value: state.userLeave.totalUsed.toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberRemaining,
                value: state.userLeave.totalRemaining.toString(),
              ),
            ],
            if (widget.takeLeaveType == EnumTakeLeaveType.compensatoryLeave) ...[
              item(
                context: context,
                title: appLocalizations.leaveNumberUsedH,
                value: (leaveOT.total / 3600).toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberPermissionH,
                value: (leaveOT.totalUsed).toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberRemainingH,
                value: (leaveOT.totalRemaining / 3600).toString(),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget item({required BuildContext context, required String title, required String value}) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
          ),
          Text(
            value,
            style: TextStyle(
                color: colors.text, fontWeight: FontWeight.w600, fontSize: SpacingUnit.x4),
          ),
        ],
      ),
    );
  }
}
