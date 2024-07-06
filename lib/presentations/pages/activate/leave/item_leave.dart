import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/leave/user_leave.dart';
import 'package:base_app/domain/entities/leave/user_leave_hisory_types.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemLeave extends StatelessWidget {
  const ItemLeave({super.key, required this.type});

  final TypeLeaveEnum type;

  UserLeaveHistoryTypes userLeaveHistoryTypes(UserLeave userLeave) {
    int index = userLeave.userLeaveHistoryTypes.indexWhere((element) => element.type == type);
    if (type == TypeLeaveEnum.total) {
      return UserLeaveHistoryTypes(
        type: type,
        total: userLeave.total,
        totalExpired: userLeave.totalExpired,
        totalRemaining: userLeave.totalRemaining,
        totalUsed: userLeave.totalUsed,
      );
    } else if (index != -1) {
      return userLeave.userLeaveHistoryTypes[index];
    }
    return UserLeaveHistoryTypes(type: type);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<WorkAndSalaryBloc, WorkAndSalaryState>(
      builder: (context, state) {
        final leave = userLeaveHistoryTypes(state.userLeave);
        return ContainerBorder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                type.configTypeLeaveEnum,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.total}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          leave.total.toString(),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.explain}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          leave.totalExpired.toString(),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.used}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          leave.totalUsed.toString(),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.remaining}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          leave.totalRemaining.toString(),
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
