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
    required this.takeLeaveType,
  });

  final EnumTakeLeaveType takeLeaveType;

  @override
  State<ItemTakeLeaveWork> createState() => _ItemTakeLeaveWorkState();
}

class _ItemTakeLeaveWorkState extends State<ItemTakeLeaveWork> {
  UserLeaveHistoryTypes _leaveOT(List<UserLeaveHistoryTypes> userLeaveHistoryTypes, TypeLeaveEnum typeLeave){
    final index = userLeaveHistoryTypes
        .indexWhere((element) => element.type == typeLeave);
    if(index != -1) {
      return userLeaveHistoryTypes[index];
    }
    else{
      return const UserLeaveHistoryTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
      builder: (context, state) {
        final leaveOT = _leaveOT(state.userLeave.userLeaveHistoryTypes, TypeLeaveEnum.overTimeLeave);
        final leaveYear = _leaveOT(state.userLeave.userLeaveHistoryTypes, TypeLeaveEnum.annualLeave);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.takeLeaveType == EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave ||
                widget.takeLeaveType == EnumTakeLeaveType.otherPaidLeave) ...[
              item(
                context: context,
                title: appLocalizations.leaveNumberUsed,
                value: leaveYear.total.toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberPermission,
                value: leaveYear.totalUsed.toString(),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberRemaining,
                value: leaveYear.totalRemaining.toString(),
              ),
            ],
            if (widget.takeLeaveType == EnumTakeLeaveType.compensatoryLeave) ...[
              item(
                context: context,
                title: appLocalizations.leaveNumberUsedH,
                value: (leaveOT.total / 3600).toStringAsFixed(3),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberPermissionH,
                value: (leaveOT.totalUsed/3600).toStringAsFixed(3),
              ),
              item(
                context: context,
                title: appLocalizations.leaveNumberRemainingH,
                value: (leaveOT.totalRemaining / 3600).toStringAsFixed(3),
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
