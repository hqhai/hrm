import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border_colum.dart';
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
          final workShiftSettings = request.config.workShiftSettings;
          workShiftSettings.sort((a, b) {
            int dateComparison = a.workDate.compareTo(b.workDate);
            if (dateComparison != 0) {
              return dateComparison;
            } else {
              return a.startTime.compareTo(b.startTime);
            }
          });
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              ItemTitleValueNoBorderColum(
                title: appLocalizations.intervalOnLeave,
                value: intervalOnLeave(
                    startDate: request.config.startDate,
                    endDate: request.config.endDate,
                    workShiftFirst: workShiftSettings.first,
                    workShiftLast: workShiftSettings.last),
                leftPadding: 0,
                size: SpacingUnit.x4,
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
                value: (request.config.numberValue).toString(),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
              ),
              TitleValueLeave(
                title: appLocalizations.statusRequest,
                value: request.status.getAppLocalizationName,
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

  String intervalOnLeave(
      {DateTime? startDate,
      DateTime? endDate,
      required WorkShiftRegisteredDetail workShiftFirst,
      required WorkShiftRegisteredDetail workShiftLast}) {
    String start = (startDate ?? '').toString();
    String end = (endDate ?? '').toString();
    String startTime = strSeconds(workShiftFirst.startTime) ?? "";
    String endTime = strSeconds(workShiftLast.endTime) ?? "";
    return '${formatYMD(start)} $startTime - ${formatYMD(end)} $endTime';
  }
}
