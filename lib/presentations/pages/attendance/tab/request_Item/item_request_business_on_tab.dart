import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRequestBusinessOnTab extends StatefulWidget {
  const ItemRequestBusinessOnTab({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ItemRequestBusinessOnTab> createState() => _ItemRequestBusinessOnTabState();
}

class _ItemRequestBusinessOnTabState extends State<ItemRequestBusinessOnTab> {
  bool checkOpacity = false;

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
                  checkUser: RequestSeeByWho.user,
                    id: widget.id, checkOpacity: checkOpacity, setState: () => setOpacity()),
              ),
              TitleValueLeave(
                title: appLocalizations.timeFrame,
                value: intervalOnLeave(request?.config.startDate, request?.config.endDate),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
              ),
              TitleValueLeave(
                title: appLocalizations.totalTime,
                value: request?.config.total.toString() ?? "",
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
}
