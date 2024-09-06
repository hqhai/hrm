import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRequestLateOrEarlyOnTab extends StatefulWidget {
  const ItemRequestLateOrEarlyOnTab({
    super.key,
    required this.id,
    required this.dateTime,
  });

  final String id;
  final DateTime dateTime;

  @override
  State<ItemRequestLateOrEarlyOnTab> createState() =>
      _ItemRequestLateOrEarlyOnTabState();
}

class _ItemRequestLateOrEarlyOnTabState
    extends State<ItemRequestLateOrEarlyOnTab> {
  bool checkOpacity = false;

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
                font: FontWeight.w600,
                title: checkType(request.config.editTimekeeping)
                    ? appLocalizations.timeLate
                    : appLocalizations.timeEarly,
                value: numberTimes(request.config.workShiftSettings),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x2,
              ),
              TitleValueLeave(
                font: FontWeight.w600,
                title: appLocalizations.reason,
                value: request.config.reason.configEnumReasonName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x2,
              ),
              if (!checkType(request.config.editTimekeeping))
                TitleValueLeave(
                  font: FontWeight.w600,
                  title: appLocalizations.makeUpTime,
                  value: strSeconds(
                          request.config.endTime - request.config.startTime) ??
                      "",
                  size: SpacingUnit.x4,
                  padding: SpacingUnit.x2,
                ),
              TitleValueLeave(
                title: appLocalizations.statusRequest,
                value: request.status.getAppLocalizationName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x2,
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

  bool checkType(EditTimekeeping? type) {
    return type == EditTimekeeping.late;
  }

  String numberTimes(List<WorkShiftRegisteredDetail> workShiftSettings) {
    final index = workShiftSettings
        .indexWhere((element) => element.workDate.day == widget.dateTime.day);
    if (index != -1) {
      return strSeconds((workShiftSettings[index].numberTime * 60).toInt()) ??
          "";
    }
    return '';
  }
}
