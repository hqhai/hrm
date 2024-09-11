import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemTakeLeaveWork extends StatefulWidget {
  const ItemTakeLeaveWork({
    super.key,
    this.reasonLeave,
    required this.type,
  });

  final EnumReasonLeave? reasonLeave;
  final EnumTakeLeaveType type;

  @override
  State<ItemTakeLeaveWork> createState() => _ItemTakeLeaveWorkState();
}

class _ItemTakeLeaveWorkState extends State<ItemTakeLeaveWork> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
      builder: (context, state) {
        final leaveOT =
            state.mapLeaveType[EnumLeaveHistoryType.overTimeLeave] ?? const UserLeaveHistoryTypes();
        final leaveSenior = state.mapLeaveType[EnumLeaveHistoryType.seniorityLeave] ??
            const UserLeaveHistoryTypes();
        final leaveYear =
            state.mapLeaveType[EnumLeaveHistoryType.annualLeave] ?? const UserLeaveHistoryTypes();
        final leaveFuneral =
            state.mapLeaveType[EnumLeaveHistoryType.funeralLeave] ?? const UserLeaveHistoryTypes();
        final leaveMarrie =
            state.mapLeaveType[EnumLeaveHistoryType.marriageLeave] ?? const UserLeaveHistoryTypes();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.reasonLeave == EnumReasonLeave.yearlyLeave &&
                widget.type != EnumTakeLeaveType.compensatoryLeave)
              ...leaveByType(leaveYear, context),
            if (widget.reasonLeave == EnumReasonLeave.seniorityLeave &&
                widget.type != EnumTakeLeaveType.compensatoryLeave)
              ...leaveByType(leaveSenior, context),
            if (widget.reasonLeave == EnumReasonLeave.mourningLeave &&
                widget.type != EnumTakeLeaveType.compensatoryLeave)
              ...leaveByType(leaveFuneral, context),
            if (widget.reasonLeave == EnumReasonLeave.weddingLeave &&
                widget.type != EnumTakeLeaveType.compensatoryLeave)
              ...leaveByType(leaveMarrie, context),
            if (widget.type == EnumTakeLeaveType.compensatoryLeave) ...[
              item(
                context: context,
                title: appLocalizations.leaveNumberUsedH,
                value: (leaveOT.total / 3600).toStringAsFixed(1),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberPermissionH,
                value: (leaveOT.totalUsed / 3600).toStringAsFixed(1),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberRemainingH,
                value: (leaveOT.totalRemaining / 3600).toStringAsFixed(1),
              ),
            ],
          ],
        );
      },
    );
  }

  List<Widget> leaveByType(UserLeaveHistoryTypes type, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return [
      item(
        context: context,
        title: appLocalizations.leaveNumberUsed,
        value: type.total.toString(),
      ),
      item(
        context: context,
        title: appLocalizations.leaveNumberPermission,
        value: type.totalUsed.toString(),
      ),
      item(
        context: context,
        title: appLocalizations.leaveNumberRemaining,
        value: type.totalRemaining.toString(),
      ),
    ];
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
