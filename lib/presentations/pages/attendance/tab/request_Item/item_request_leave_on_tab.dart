import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRequestOnTab extends StatefulWidget {
  const ItemRequestOnTab({super.key, required this.id});

  final String id;

  @override
  State<ItemRequestOnTab> createState() => _ItemRequestOnTabState();
}

class _ItemRequestOnTabState extends State<ItemRequestOnTab> {
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
          final request = state.mapRequests[widget.id] ?? const Request(id: '');
          return Column(
            children: [
              ItemTypeOnTab(
                type: request.flowType.configTypeName,
                callback: () => nextScreenRequest(
                    context: context,
                    checkUser: RequestSeeByWho.user,
                    id: widget.id,
                    checkOpacity: checkOpacity,
                    setState: () => setOpacity()),
              ),
              TitleValueLeave(
                title: appLocalizations.intervalOnLeave,
                value: intervalOnLeave(request.config.startDate, request.config.endDate),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
              ),
              TitleValueLeave(
                title: appLocalizations.typeRequest,
                value: request.flowType.configTypeName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
              ),
              TitleValueLeave(
                title: appLocalizations.reason,
                value: request.config.takeLeaveType.configTakeLeaveTypeName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
              ),
              TitleValueLeave(
                title: appLocalizations.totalLeaveWork,
                value: (request.config.numberValue ?? 0).toString(),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
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
}
