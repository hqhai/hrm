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
import 'package:base_app/presentations/pages/activate/leave/padding_row_leave.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
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
              PaddingRowLeave(
                title1: appLocalizations.day,
                title2: appLocalizations.totalLeaveOfChanges,
                value1: formatYMD((leave?.createdDate ?? "").toString()),
                value2: totalLeaveOfChanges(leave?.changeType, leave?.changeValue),
                color: check(leave?.changeType ?? ChangeTypeEnum.addition)
                    ? colors.success
                    : colors.error,
              ),
              PaddingRowLeave(
                title1: appLocalizations.actionName,
                title2: appLocalizations.totalRemainingLeaveDays,
                value1: leave?.changeType.configChangeTypeEnum ?? "",
                value2: (leave?.totalRemaining ?? 0).toString(),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x3),
                child: TitleValueLeave(
                  title: appLocalizations.sourceOfLeave,
                  value: leave?.type.configTypeLeaveEnum ?? "",
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

  String totalLeaveOfChanges(ChangeTypeEnum? type, double? change) {
    return '${check(type ?? ChangeTypeEnum.addition) ? '+' : '-'}${(change ?? 0).toString()}';
  }

  bool check(ChangeTypeEnum type) {
    return type == ChangeTypeEnum.addition;
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
