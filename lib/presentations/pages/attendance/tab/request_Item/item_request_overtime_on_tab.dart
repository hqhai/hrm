import 'package:base_app/common/enum/requisition_enum.dart';

import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRequestOverTimeOnTab extends StatefulWidget {
  const ItemRequestOverTimeOnTab({
    super.key,
    required this.id,
    required this.dateTime,
  });

  final String id;
  final DateTime dateTime;

  @override
  State<ItemRequestOverTimeOnTab> createState() => _ItemRequestOverTimeOnTabState();
}

class _ItemRequestOverTimeOnTabState extends State<ItemRequestOverTimeOnTab> {
  bool checkOpacity = false;

  Request requestById(List<Request> requests) {
    return requests.firstWhere((element) => element.id == widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ItemRequestOnTabCommon(
      checkOpacity: checkOpacity,
      child: BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
        builder: (context, state) {
          final request = state.mapRequests[widget.id];
          return Column(
            children: [
              ItemTypeOnTab(
                type: request?.flowType.configTypeName ?? "",
                callback: () => nextScreenRequest(
                    id: widget.id, checkOpacity: checkOpacity, setState: () => setOpacity()),
              ),
              TitleValueLeave(
                title: appLocalizations.timeFrameOT,
                value: setOTTime(request?.config.overTimes, context),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
              ),
              TitleValueLeave(
                title: appLocalizations.totalOTHours,
                value: setTotalOT(request?.config.overTimes),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
              ),
            ],
          );
        },
      ),
    );
  }

  setOpacity() {
    setState(() {
      checkOpacity = !checkOpacity;
    });
  }

  String setOTTime(List<RequisitionOverTime>? overTimes, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final listOT = overTimes ?? [];
    final index = listOT.indexWhere((element) => element.date == widget.dateTime);
    if (index != -1) {
      final startTime = listOT[index].startTime != null
          ? strSeconds(listOT[index].startTime!)
          : appLocalizations.forgotChecking;
      final endTime = listOT[index].startTime != null
          ? strSeconds(listOT[index].endTime!)
          : appLocalizations.forgotChecking;
      return '$startTime - $endTime';
    }
    return '';
  }

  String setTotalOT(List<RequisitionOverTime>? overTimes) {
    final listOT = overTimes ?? [];
    final index = listOT.indexWhere((element) => element.date == widget.dateTime);
    if (index != -1) {
      final time = listOT[index].suggestTime ?? 0;
      return (time / 3600).toString();
    }
    return '';
  }
}
