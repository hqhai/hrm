import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/work_and_salary/work_and_salary_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemTakeLeaveWork extends StatefulWidget {
  const ItemTakeLeaveWork({super.key,});


  @override
  State<ItemTakeLeaveWork> createState() => _ItemTakeLeaveWorkState();
}

class _ItemTakeLeaveWorkState extends State<ItemTakeLeaveWork> {

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Row(
                children: [
                  Text(
                    appLocalizations.leaveNumberPermission,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4,
                  ),
                  Text(
                    state.permission.toString(),
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Row(
                children: [
                  Text(
                    appLocalizations.leaveNumberUsed,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4,
                  ),
                  Text(
                    state.used.toString(),
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Row(
                children: [
                  Text(
                    appLocalizations.leaveNumberRemaining,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4,
                  ),
                  Text(
                    state.remaining.toString(),
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4),
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
