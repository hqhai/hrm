import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/extra/requisition_information_extra.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_bloc.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemLeaveHistory extends StatefulWidget {
  const ItemLeaveHistory({
    super.key,
    required this.userLeaveHistoryId,
  });

  final String userLeaveHistoryId;

  @override
  State<ItemLeaveHistory> createState() => _ItemLeaveHistoryState();
}

class _ItemLeaveHistoryState extends State<ItemLeaveHistory> {
  bool checkOpacity = true;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<LeaveHistoryBloc, LeaveHistoryState>(
      builder: (context, state) {
        final leave = state.userLeaveHistory[widget.userLeaveHistoryId];
        return ContainerBorder(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${appLocalizations.day}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          formatYMD((leave?.createdDate ?? "").toString()),
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
                          '${appLocalizations.totalLeaveOfChanges}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          (leave?.changeValue ?? 0).toString(),
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
                          '${appLocalizations.actionName}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          leave?.changeType.configChangeTypeEnum ?? "",
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
                          '${appLocalizations.totalRemainingLeaveDays}: ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          (leave?.totalRemaining ?? 0).toString(),
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
                  children: [
                    Text(
                      '${appLocalizations.sourceOfLeave}: ',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x3,
                      ),
                    ),
                    Text(
                      leave?.type.configTypeLeaveEnum ?? "",
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x3,
                      ),
                    ),
                  ],
                ),
              ),
              if (leave?.requestId.isNotEmpty ?? false)
                GestureDetector(
                  onTap: () => _nextRequisitionInformationScreen(
                    context,
                    state.userLeaveHistory[widget.userLeaveHistoryId]!.requestId,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x3),
                    child: Text(
                      appLocalizations.seeRequest,
                      style: TextStyle(
                        color: colors.success,
                        fontSize: SpacingUnit.x3,
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  _nextRequisitionInformationScreen(BuildContext context, String idRequest) async {
    final RequisitionInformationExtra extra = RequisitionInformationExtra(
      id: idRequest,
      checkUser: false,
    );
    if (!checkOpacity) {
      setState(() {
        checkOpacity = true;
      });
      final Completer completer = Completer<RequisitionEnum>();
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: idRequest, completer: completer),
      );
      final statusCompleter = await completer.future;
      if (statusCompleter == RequisitionEnum.success) {
        setState(() {
          checkOpacity = false;
        });
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pushName(
          currentContext,
          page: Pages.requisitionInformationPage,
          extra: extra.toJson()
        );
      }
    }
  }
}
